### Workshop #1

# CircleSpawn App

### Opis zadania

Celem zadania jest przygotowanie prostej aplikacji **CircleSpawn**. Apka składa się z jednego ekranu, na którym użytkownik może tworzyć i przesuwać kolorowe kółka.

Tapując dwa razy w dowolnym miejscu na ekranie aplikacji, powodujemy stworzenie nowego kółka w losowym kolorze o rozmiarze `100x100` (w miejscu tapnięcia).

Przytrzymując kółko, które jest na ekranie, wywołujemy animację *podnoszenia* go (scale up + lekki fadeout). Następnie przesuwając palcem po ekranie przesuwamy kółko po ekranie. Puszczenie kółka powoduje jego *opadnięcie* na ekran w nowym miejscu (animacja odwrotna do poprzedniej).

Dodatkowy feature pozwala na usuwanie kółek – trzykrotny *tap* na kółko powoduje jego usunięcie (oczywiście z animacją). [Tutaj](film.mov) możecie zobaczyć prezentację działającej aplikacji.

### Wskazówki

1. Kółko zrealizuj przy pomocy `UIView` o odpowiednim rozmiarze z `backgroundColor`. Aby z kwadratu zrobić kółko wykorzystaj property `view.layer.cornerRadius`.
2. Losowy kolor wygeneruj przy pomocy ponizszej funkcji:
```swift
extension CGFloat {
  static func random() -> CGFloat {
    return random(min: 0.0, max: 1.0)
  }

  static func random(min: CGFloat, max: CGFloat) -> CGFloat {
    assert(max > min)
    return min + ((max - min) * CGFloat(arc4random()) / CGFloat(UInt32.max))
  }
}

extension UIColor {
  static func randomBrightColor() -> UIColor {
    return UIColor(hue: .random(),
             saturation: .random(min: 0.5, max: 1.0),
             brightness: .random(min: 0.7, max: 1.0),
             alpha: 1.0)
  }
}
```

3. Nie używaj AutoLayout'u w tym zadaniu – nie jest potrzebny, a tylko utrudni Ci życie.
4. Podwójny i potrójny tap obsłuż przy pomocy `UITapGestureRecognizer` (wystarczy skonfigurować `numberOfTapsRequired`)
5. Podniesienie i przenoszenie obsłuż przy pomocy `UILongPressGestureRecognizer`
6. Użyj `UIGestureRecognizerDelegate`, aby synchronizować współpracę gestów ze sobą
7. Jak zawsze: korzystaj z [dokumentacj](https://developer.apple.com/documentation/uikit/uigesturerecognizer)!
8. Domyślne zachowanie gestów jest takie, że ten gest który pierwszy przejdzie do stanu `began`/`recognized` – ten wygrywa – reszta dostaje *cancel*. Mechanizm sprawdza się w 90%, ale nie w tym przypadku (kiedy w tej samej hierarchii potrzebujemy obsłużyć triple tap i double tap). Aby móc rozpoznać gest triple tap bez rozpoznania wcześniej double tap – należy skorzystać z *failure requirements*. Ten mechanizm interakcji instancji UIGestureRecognizer ze sobą jest obsługiwany przez [UIGestureRecognizerDelegate](https://developer.apple.com/documentation/uikit/uigesturerecognizerdelegate).
9. Zwróć uwagę, żeby podniesione kółko nie *skakało* zaraz po podniesieniu, jeśli nie złapiemy go za sam środek.
10. 

### Odpowiedzi

Odpowiedź (cały, spakowany w .zip folder projektu) wyślij mailem na adres [email](ios@daftacademy.pl) do końca najbliższej soboty: **16.03.2019, 23:59**.
