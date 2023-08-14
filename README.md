# phone_form_field

The Phone Form Field is a versatile package that provides cross-platform support for phone number input fields. This package is designed to simplify the process of capturing phone numbers from users.

## Features

- Cross-Platform Compatibility
- Automated phone number formatting
- Realm-Time phone number validation
- Different methods for selecting countries with flexible customization
- Integration with Customs Text Fields
- Localization for different regions

## Demo

<img src="https://raw.githubusercontent.com/LanarsInc/phone_form_field/refactor/country_selector/example/assets/phone_form_field_example.gif" width="356">

## Usage

Just create a phone form field widget and pass desired country selector that's it, you can already use it.

```dart

PhoneFormField(countrySelectorNavigator: const CountrySelectorNavigator.dialog()),

```
Of course, you can pass any available params for customization of your Phone Form Field

```dart

PhoneFormField(
key: const Key('phone-field'),
controller: null,     // Phone controller 
initialValue: null,   // can't be supplied simultaneously with a controller
shouldFormat: true    // default 
defaultCountry: IsoCode.US, // default 
decoration: InputDecoration(
labelText: 'Phone',          // default to null
border: OutlineInputBorder() // default to UnderlineInputBorder(),
// ...
),
validator: PhoneValidator.validMobile(),   // default PhoneValidator.valid()
isCountrySelectionEnabled: true, // default
countrySelectorNavigator: CountrySelectorNavigator.bottomSheet(),
showFlagInInput: true,  // default
isFlagCircle: true, // defaule
showArrow = true,
flagSize: 16,           // default
autofillHints: [AutofillHints.telephoneNumber], // default to null
enabled: true,          // default
autofocus: false,       // default
onSaved: (PhoneNumber p) => print('saved $p'),   // default null
onChanged: (PhoneNumber p) => print('saved $p'), // default null
// ... + other textfield params
)

```

## Validation

### Built-in validators

* required : `PhoneValidator.required`
* valid : `PhoneValidator.valid` (default value if no other validator is specified)
* valid mobile number : `PhoneValidator.validMobile`
* valid fixed line number : `PhoneValidator.validFixedLine`
* valid type : `PhoneValidator.validType`
* valid country : `PhoneValidator.validCountry`
* none : `PhoneValidator.none` (use this to disable the default validator)

### Validators details

* The phone_form_field package includes a number of built-in validators for phone numbers. Each validator can be customized with an optional `errorText` property to change the displayed error message.
* Most of the validators have an optional `allowEmpty` property that prevents the field from being flagged as valid if it is empty. This can be useful if you want to display a different error message for empty fields.

### Composing validators

You can also create your own custom validators by using the PhoneValidator.compose() method. This method takes a list of built-in or custom validators as input and combines the functionality of all of the input validators.

Note that when composing validators, the sorting is important as the error message displayed is the first validator failing.

```dart

PhoneFormField(
  // ...
  validator: PhoneValidator.compose([
    // list of validators to use
    PhoneValidator.required(errorText: "You must enter a value"),
    PhoneValidator.validMobile(),
    // ..
  ]),
)

```

## Country selector

You can choose from many different selectors to select a country. All of them are flexibly customizable, and the default appearance selectors like dialog and bottom sheets depends on your app's theme settings.

Here is the list of the parameters available for all built-in country selector:

| Name | Default value | Description |
|---|---|---|
| countries | null | Countries available in list view (all countries are listed when omitted) |
| favorites | null | List of country code `['FR','UK']` to display on top of the list |
| addSeparator | true | Whether to add a separator between favorite countries and others one. Useless if `favorites` parameter is null |
| showCountryCode | true | Whether to display the country dial code as listTile item subtitle |
| showCountryName | true | Determines if the country name should be shown. |
| showCountryFlag | true | Determines if the country flag should be shown |
| noResultMessage | null | The message to be displayed in place of the list when a search result is empty (a default localised message is used when omitted) |
| countryCodeStyle | null | The text style of country code |
| countryNameStyle | null | The text style of country name |
| flagSize | 48 | Flag icon size |
|isFlagCircle| true | Determines if the displayed flags should be circular. |

### Built-in country selector

* **CountrySelectorNavigator.searchDelegate**
  Open a page for choosing the country.
  No extra parameters.

* **CountrySelectorNavigator.dialog**
  Open a dialog to select the country.
  Extra parameters:
  * `showSearchInput` Whether to show the search input
  * `searchInputDecoration` The [InputDecoration] of the Search Input
  * `searchInputTextStyle` The [TextStyle] of the Search Input
  * `defaultSearchInputIconColor` The [Color] of the Search Icon in the Search Input
  * `searchInputHeight` The height of the search input field, if specified.
  * `searchInputWidth` The width of the search input field, if specified.

* **CountrySelectorNavigator.bottomSheet**
  Open a bottom sheet expanding to all available space in both axis
  Extra parameters:
  * `bottomSheetDragHandlerColor` The [Color] of the divider at the top on the bottom sheet
    and other extra params as in the dialog

* **CountrySelectorNavigator.modalBottomSheet**
  Open a modal bottom sheet expanded horizontally
  Extra parameters:
  * `height` (double, default null) Allow to determine the height of the bottom sheet
    and other extra params as in the bottomSheet

* **CountrySelectorNavigator.draggableBottomSheet**
  Open a modal bottom sheet expanded horizontally which may be dragged from a minimum to a maximum of current available height.
  Uses internally the `DraggableScrollableSheet` flutter widget
  Extra parameters:
  * `initialChildSize` (double, default: `0.5`) factor of current available height used when opening
  * `minChildSize` (double, default: `0.Z5`) : maximum factor of current available height
  * `minChildSize` (double, default: `0.Z5`) : minimum factor of current available height
  * `borderRadius` (BorderRadiusGeometry, default: 16px circular radius on top left/right)
    and other extra params as in the dialog

* **CountrySelectorNavigator.dropdown**
  Open a dropdown menu under text input with customizable height.
  Since dropdown is implemented using overlay it is necessary to pass Layer Link.
  Extra parameters:
  * required `layerLink` The LayerLink for overlay positioning
  * `borderRadius` The dropdown's border radius
  * `listHeight` The height of the dropdown list
  * `backgroundColor` The background color of the dropdown
    and other extra params as in the dialog

## Integration with Customs Text Fields

You can utilize any country selectors with either a customized or standard text field, allowing you to obtain an instance of the chosen country.
To achieve this, you only need to invoke the requestCountrySelector() function on the desired selector while providing the necessary parameters.
For example:

```dart

TextField(
  onTap: () async {
    final country = await CountrySelectorNavigator.dialog().requestCountrySelector(context);
    print(country);
  },
),


```

Note that with bottomSheet selector, you need to additionally wrap the TextField in Builder.
Example:

```dart

Builder(
  builder: (context) {
    return TextField(
      onTap: () async {
      final country = await const CountrySelectorNavigator.bottomSheet().requestCountrySelector(context);
      print(country);
      },
    );
  },
),

```

Also note that with dropdown selector, you need to additionally wrap TextField in CompositedTransformTarget, pass LayerLink to it and inside pass TextField wrapped in Builder.
Also note the integration with the dropdown selector
1. Start by wrapping your TextField with CompositedTransformTarget.
2. Provide a LayerLink to CompositedTransformTarget.
3. Wrap Your TextField with a Builder.
   For example:

```dart 

CompositedTransformTarget(
  link: layerLink,
    child: Builder(
      builder: (context) {
        return TextField(
        onTap: () {
        final country = CountrySelectorNavigator.dropdown(
          backgroundColor: Colors.red,
          layerLink: layerLink,
          showSearchInput: true,
          ).requestCountrySelector(context);
        },
      );
    },
  ),
),

```

## Internationalization

Include the delegate

```dart
    return MaterialApp(
localizationsDelegates: [
GlobalMaterialLocalizations.delegate,
PhoneFieldLocalization.delegate
],
supportedLocales: [
const Locale('en', ''),
const Locale('es', ''),
const Locale('fr', ''),
const Locale('ru', ''),
const Locale('uk', ''),
// ...
],
```

A bunch of languages are built-in:

    - 'ar',
    - 'de',
    - 'en',
    - 'el'
    - 'es',
    - 'fr',
    - 'hin',
    - 'it',
    - 'nl',
    - 'pt',
    - 'ru',
    - 'uk',
    - 'tr',
    - 'zh',
    - 'sv',
