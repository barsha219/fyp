import 'package:beauty_store/config/app_config.dart';
import 'package:beauty_store/meta/screens/dashboard/dashboard.dart';
import 'package:beauty_store/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class GetStartedView extends StatefulWidget {
  const GetStartedView({Key? key}) : super(key: key);

  @override
  State<GetStartedView> createState() => _GetStartedViewState();
}

class _GetStartedViewState extends State<GetStartedView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 210),
              Text(
                AppConfig.appName,
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Text(
                  "We guarantee that you will receive the \n best service possible at all times. we \n offer the widest range of services and \n products to meet your needs. Make your \n in the simplest way possible appointments.",
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(fontSize: 14),
                  textAlign: TextAlign.center),
              const SizedBox(
                height: 260,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: PrimaryButton(
                  title: "Get Started",
                  onTap: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => DashBoardView()),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
