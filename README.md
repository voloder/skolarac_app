
# Uvod

U ovom projektu koristili smo Flutter 3.16.7

Od external biblioteka koristili smo:
- lottie: ^3.0.0
- neon_circular_timer: ^0.0.7
- provider: ^6.1.1
- shared_preferences: ^2.2.2
- socket_io_client: ^2.0.3+1

## Pokretanje

Da biste instalirali sve biblioteke, pokrenite `flutter pub get` u root direktoriju.

Za pokretanje koda, pokrenite `flutter run`.

Za buildanje koda, pokrenite `flutter build apk` ili `flutter build appbundle`.

## Struktura

Backend singleton koji se inicijalizira na početku i koriste ga sve ostale klase

Po defaultu, backend je `xudev.io:8000`. Pročitajte README.md backenda kako biste lokalno hostovali.

U /model su modeli podataka, a u /stranice su stranice koje se prikazuju

