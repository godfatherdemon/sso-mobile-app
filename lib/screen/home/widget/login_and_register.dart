import 'package:flutter/material.dart';
import 'package:usluge_client/screen/login/login_screen.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:webview_flutter/webview_flutter.dart';

import '../../../constant.dart';

class LoginAndRegister extends StatelessWidget {
  const LoginAndRegister({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Either load an OAuth2 client from saved credentials or authenticate a new
    /// one.
    Future<oauth2.Client> createClient() async {
      final authorizationEndpoint = Uri.parse(
          'http://192.168.1.2:8080/auth/realms/SpringBootKeycloak2/protocol/openid-connect/auth');
      final tokenEndpoint = Uri.parse(
          'http://192.168.1.2:8080/auth/realms/SpringBootKeycloak2/protocol/openid-connect/token');

      // The authorization server will issue each client a separate client
      // identifier and secret, which allows the server to tell which client
      // is accessing it. Some servers may also have an anonymous
      // identifier/secret pair that any client may use.
      //
      // Note that clients whose source code or binary executable is readily
      // available may not be able to make sure the client secret is kept a
      // secret. This is fine; OAuth2 servers generally won't rely on knowing
      // with certainty that a client is who it claims to be.
      final identifier = 'my-client-id';
      final secret = '28d97248-7bcc-4382-86de-d2311c74669e';

      // This is a URL on your application's server. The authorization server
      // will redirect the resource owner here once they've authorized the
      // client. The redirection will include the authorization code in the
      // query parameters.
      final redirectUrl = Uri.parse('http://localhost:3000/');

      var grant = oauth2.AuthorizationCodeGrant(
        identifier,
        authorizationEndpoint,
        tokenEndpoint,
        // secret: secret,
      );

      // A URL on the authorization server (authorizationEndpoint with some additional
      // query parameters). Scopes and state can optionally be passed into this method.
      var authorizationUrl = grant.getAuthorizationUrl(redirectUrl);

      Uri responseUrl = Uri.parse("http://localhost:3000/");

      await Navigator.push(
          context,
          MaterialPageRoute(
              fullscreenDialog: true,
              builder: (_) {
                // Redirect the resource owner to the authorization URL. Once the resource
                // owner has authorized, they'll be redirected to `redirectUrl` with an
                // authorization code. The `redirect` should cause the browser to redirect to
                // another URL which should also have a listener.
                return SafeArea(
                  child: Container(
                    child: WebView(
                      javascriptMode: JavascriptMode.unrestricted,
                      initialUrl: authorizationUrl.toString(),
                      navigationDelegate: (navigationRequest) {
                        if (navigationRequest.url
                            .startsWith(redirectUrl.toString())) {
                          responseUrl = Uri.parse(navigationRequest.url);
                          print('Response URL: $responseUrl}');
                          Navigator.pop(context);
                          return NavigationDecision.prevent;
                        }
                        return NavigationDecision.navigate;
                      },
                    ),
                  ),
                );
              }));

      // Once the user is redirected to `redirectUrl`, pass the query parameters to
      // the AuthorizationCodeGrant. It will validate them and extract the
      // authorization code to create a new Client.
      return grant.handleAuthorizationResponse(responseUrl.queryParameters);
    }

    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Row(children: <Widget>[
          Expanded(
            child: TextButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: mPrimaryColor, // background
                foregroundColor: Colors.white, // foreground
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(36)),
              ),
              onPressed: () {},
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                alignment: Alignment.center,
                width: double.infinity,
                child: const Text("Register",
                    style: TextStyle(
                      color: Colors.white,
                    )),
              ),
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          Expanded(
            child: TextButton(
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, // foreground
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(36)),
                  side: BorderSide(color: mPrimaryColor)),
              onPressed: () {
                var kcClient = createClient();
                print("CVELE ${kcClient}");
                // Navigator.push(context, MaterialPageRoute(
                //   builder: (context) {
                //     return const LoginScreen();
                //   },
                // ));
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                alignment: Alignment.center,
                width: double.infinity,
                child: Text("Login",
                    style: TextStyle(
                      color: mPrimaryColor,
                    )),
              ),
            ),
          )
        ]));
  }
}
