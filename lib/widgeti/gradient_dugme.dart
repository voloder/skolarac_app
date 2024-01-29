import 'package:flutter/material.dart';

class GradientDugme extends StatelessWidget {
  final Color boja1;
  final Color boja2;
  final String naslov;
  final String slika;

  final String? naslovHero;
  final String? slikaHero;

  final VoidCallback onPressed;
  final int flex;

  const GradientDugme(
      {super.key,
      required this.boja1,
      required this.boja2,
      required this.naslov,
      required this.slika,
        required this.onPressed,
        this.naslovHero, this.slikaHero, this.flex = 1});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  boja1,
                  boja2,
                ],
              )),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Padding(
                    padding: EdgeInsets.only(top: 10, left: 25),
                    child: naslovHero != null ?  Hero(
                      tag: naslovHero!,
                      child: Text(naslov,
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(color: Colors.white)),
                    ) : Text(naslov,
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(color: Colors.white))
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8, right: 30),
                child: slikaHero != null ? Hero(
                    tag: slikaHero!,
                    child: Image.asset(slika)) : Image.asset(slika),
              )
            ],
          ),
        ),
      ),
    );
  }
}
