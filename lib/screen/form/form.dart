import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:usluge_client/screen/main/main_screen.dart';
import 'package:http/http.dart' as http;

class SendForm extends StatelessWidget {
  const SendForm({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SendFormBloc(),
        child: Builder(builder: (context) {
          final sendFormBloc = context.read<SendFormBloc>();
          return Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(title: Text('Zatraži uslugu')),
              body: FormBlocListener<SendFormBloc, String, String>(
                onSubmitting: (context, state) {
                  LoadingDialog.show(context);
                },
                onSubmissionFailed: (context, state) {
                  LoadingDialog.hide(context);
                },
                onSuccess: (context, state) {
                  LoadingDialog.hide(context);

                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => SuccessScreen()));
                },
                onFailure: (context, state) {
                  LoadingDialog.hide(context);

                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Greška pokušajte ponovo!")));
                },
                child: SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: Column(
                    children: <Widget>[
                      TextFieldBlocBuilder(
                        textFieldBloc: sendFormBloc.serviceName,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'Opišite koja usluga Vam je potrebna?',
                          prefixIcon: Icon(Icons.add_task),
                        ),
                      ),
                      TextFieldBlocBuilder(
                        textFieldBloc: sendFormBloc.price,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Navedite cenu ove usluge u RSD',
                          prefixIcon: Icon(Icons.money_rounded),
                        ),
                      ),
                      DropdownFieldBlocBuilder<String>(
                        selectFieldBloc: sendFormBloc.selectLocation,
                        decoration: const InputDecoration(
                          labelText: 'Izaberite lokaciju',
                          prefixIcon: Icon(Icons.location_city),
                        ),
                        itemBuilder: (context, value) => FieldItem(
                          child: Text(value),
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: CheckboxFieldBlocBuilder(
                          booleanFieldBloc: sendFormBloc.showSecretField,
                          controlAffinity:
                              FieldBlocBuilderControlAffinity.trailing,
                          body: Container(
                            alignment: Alignment.center,
                            child:
                                const Text('Vaša usluga je vremenski zavisna?'),
                          ),
                        ),
                      ),
                      DateTimeFieldBlocBuilder(
                        dateTimeFieldBloc: sendFormBloc.dateAndTime1,
                        canSelectTime: true,
                        format: DateFormat('dd-MM-yyyy  hh:mm'),
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2022),
                        lastDate: DateTime(2024),
                        decoration: const InputDecoration(
                          labelText: 'Izaberite za kada Vam treba usluga',
                          prefixIcon: Icon(Icons.date_range),
                          helperText: 'Datum i satnica',
                        ),
                      ),
                      ElevatedButton(
                        onPressed: sendFormBloc.submit,
                        child: const Text('Zatraži uslugu'),
                      ),
                    ],
                  ),
                ),
              ));
        }));
  }
}

class LoadingDialog extends StatelessWidget {
  static void show(BuildContext context, {Key? key}) => showDialog<void>(
        context: context,
        useRootNavigator: false,
        barrierDismissible: false,
        builder: (_) => LoadingDialog(key: key),
      ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  static void hide(BuildContext context) => Navigator.pop(context);

  const LoadingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Card(
          child: Container(
            width: 80,
            height: 80,
            padding: const EdgeInsets.all(12.0),
            child: const CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(Icons.tag_faces, size: 100),
            const SizedBox(height: 10),
            const Text(
              'Čestitamo, uspešno ste zatražili uslugu!',
              style: TextStyle(fontSize: 54, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const MainScreen())),
              icon: const Icon(Icons.replay),
              label: const Text('POVRATAK NA MENI'),
            ),
          ],
        ),
      ),
    );
  }
}

class SendFormBloc extends FormBloc<String, String> {
  final serviceName = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
    ],
  );
  final price = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
    ],
  );
  final dateAndTime1 = InputFieldBloc<DateTime?, dynamic>(initialValue: null);
  final showSecretField = BooleanFieldBloc();
  final selectLocation = SelectFieldBloc(
    validators: [
      FieldBlocValidators.required,
    ],
    items: ['Novi Sad', 'Beograd', 'Nis', 'Cacak', 'Kragujevac'],
  );

  SendFormBloc() {
    addFieldBlocs(
      fieldBlocs: [
        serviceName,
        price,
        selectLocation,
        showSecretField,
      ],
    );
    showSecretField.onValueChanges(
      onData: (previous, current) async* {
        if (current.value) {
          addFieldBlocs(fieldBlocs: [dateAndTime1]);
        } else {
          removeFieldBlocs(fieldBlocs: [dateAndTime1]);
        }
      },
    );
  }

  @override
  Future<void> close() {
    showSecretField.close();
    dateAndTime1.close();
    return super.close();
  }

  @override
  Future<FutureOr<void>> onSubmitting() async {
    bool timedOut = false;
    String url = 'http://trebam.me:8082/api/v1/addOffer';
    Map data = {
      'title': serviceName.value,
      'price': price.value,
      'location': selectLocation.value,
      'owner': 'Stefan-Flutter'
    };
    if (dateAndTime1.value != null) {
      data['executionTime'] = dateAndTime1.value?.toIso8601String();
    }

    var body = json.encode(data);
    var response = await http
        .post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: body,
    )
        .timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        timedOut = true;
        return http.Response(
            'Error', 408); // Request Timeout response status code
      },
    );

    await Future<void>.delayed(Duration(seconds: 1));
    if (response.statusCode != 200) {
      emitFailure(failureResponse: 'Greška pokušajte ponovo!');
    } else {
      emitSuccess();
    }
  }
}
