# Rahmen & Eckenrundung (Borders & Rounded)

Die `BsBorderExtension` bietet Bootstrap-konforme Rahmen- und Abrundungseffekte für jedes Flutter-Widget.

## Rahmen (Borders)

### Randstile

| Methode | Beschreibung | Entspricht Bootstrap |
| :--- | :--- | :--- |
| `.border({color, width})` | Fügt einen Standardrahmen auf allen Seiten hinzu. | `.border` |
| `.border0()` | Entfernt alle Rahmen. | `.border-0` |
| `.borderTop({color, width})` | Fügt einen Rahmen an der Oberseite hinzu. | `.border-top` |
| `.borderBottom({color, width})` | Fügt einen Rahmen an der Unterseite hinzu. | `.border-bottom` |
| `.borderStart({color, width})` | Fügt einen Rahmen am Anfang (links) hinzu. | `.border-start` |
| `.borderEnd({color, width})` | Fügt einen Rahmen am Ende (rechts) hinzu. | `.border-end` |

```dart
// Standardrahmen
Text('Inhalt').border();

// Dicker roter Rahmen oben
Text('Inhalt').borderTop(color: Colors.red, width: 3.0);
```

### Rahmenfarben (Border Color)

| Methode | Beschreibung | Entspricht Bootstrap |
| :--- | :--- | :--- |
| `.borderVariant(context, variant, {width})` | Färbt den Rahmen basierend auf den Bootstrap-Themenfarben. | `.border-*` |

```dart
// Rahmen mit der Bootstrap "primary" Themenfarbe
Text('Inhalt').borderVariant(context, BsVariant.primary);
```

---

## Eckenrundung (Rounded Corners)

| Methode | Beschreibung | Entspricht Bootstrap |
| :--- | :--- | :--- |
| `.rounded()` | Standardmäßige Abrundung von 6px. | `.rounded` |
| `.rounded0()` | Entfernt jegliche Abrundung. | `.rounded-0` |
| `.rounded1()` | Abrundung von 4px. | `.rounded-1` |
| `.rounded2()` | Abrundung von 6px. | `.rounded-2` |
| `.rounded3()` | Abrundung von 8px. | `.rounded-3` |
| `.rounded4()` | Abrundung von 16px. | `.rounded-4` |
| `.rounded5()` | Abrundung von 32px. | `.rounded-5` |
| `.roundedCircle()` | Macht das Element kreisförmig. | `.rounded-circle` |
| `.roundedPill()` | Kapselform (vollständig abgerundete Enden). | `.rounded-pill` |
| `.roundedTop({radius})` | Abrundung nur an der Oberseite. | `.rounded-top` |
| `.roundedBottom({radius})` | Abrundung nur an der Unterseite. | `.rounded-bottom` |
| `.roundedStart({radius})` | Abrundung nur am Anfang (links). | `.rounded-start` |
| `.roundedEnd({radius})` | Abrundung nur am Ende (rechts). | `.rounded-end` |

```dart
// Pille-förmiges Widget
Container(color: Colors.blue).roundedPill();

// Kreisförmiges Bild
Image.asset('bild.png').roundedCircle();
```
