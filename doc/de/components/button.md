# Button

Die `BsButton` Komponente bietet verschiedene Stile für Aktionen in Formularen, Dialogen und mehr.

## Verwendung

```dart
BsButton(
  label: 'Klick mich',
  onPressed: () => print('Geklickt!'),
  variant: BsButtonVariant.primary,
  size: BsButtonSize.md,
)
```

## Eigenschaften

| Eigenschaft | Typ | Standard | Beschreibung |
| :--- | :--- | :--- | :--- |
| `label` | `String` | **Erforderlich** | Der Text auf dem Button. |
| `onPressed` | `VoidCallback?` | `null` | Die Funktion, die beim Klick ausgeführt wird. Ist sie `null`, ist der Button deaktiviert. |
| `variant` | `BsButtonVariant` | `BsButtonVariant.primary` | Der Stil des Buttons (z.B. primary, outlineSuccess, link). |
| `size` | `BsButtonSize` | `BsButtonSize.md` | Die Größe des Buttons (sm, md, lg). |
| `isLoading` | `bool` | `false` | Zeigt einen Ladeindikator an und deaktiviert den Button. |
| `icon` | `IconData?` | `null` | Ein optionales Icon. |
| `iconVariant` | `BsIconVariant?` | `null` | Spezifisches Farbschema für das Icon. |
| `iconColor` | `Color?` | `null` | Direkte Farbwahl für das Icon. |
| `fullWidth` | `bool` | `false` | Wenn `true`, nimmt der Button die volle verfügbare Breite ein. |
| `badge` | `Widget?` | `null` | Ein optionales Badge im oder am Button. |
| `badgePosition` | `BsBadgePosition` | `BsBadgePosition.trailing` | Position des Badges (leading, trailing, oder absolut in den Ecken). |

---

# Button Group

Mit `BsButtonGroup` können mehrere Buttons in einer Reihe oder Spalte gruppiert werden.

## Verwendung

```dart
BsButtonGroup(
  children: [
    BsButton(label: 'Links', onPressed: () {}),
    BsButton(label: 'Mitte', onPressed: () {}),
    BsButton(label: 'Rechts', onPressed: () {}),
  ],
)
```

## Eigenschaften

| Eigenschaft | Typ | Standard | Beschreibung |
| :--- | :--- | :--- | :--- |
| `children` | `List<BsButton>` | **Erforderlich** | Die Liste der Buttons in der Gruppe. |
| `vertical` | `bool` | `false` | Wenn `true`, werden die Buttons vertikal untereinander angeordnet. |
| `groupSize` | `BsButtonSize?` | `null` | Überschreibt die Größe aller Buttons in der Gruppe. |
