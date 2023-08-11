import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field_package.dart';

void main() {
  runApp(const PhoneFormFieldApp());
}

class PhoneFormFieldApp extends StatelessWidget {
  const PhoneFormFieldApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const PhoneFormFieldPage(),
    );
  }
}

class PhoneFormFieldPage extends StatefulWidget {
  const PhoneFormFieldPage({super.key});

  @override
  State<PhoneFormFieldPage> createState() => _PhoneFormFieldPageState();
}

enum FieldType { outlined, underlined }

class _PhoneFormFieldPageState extends State<PhoneFormFieldPage> {
  FieldType fieldType = FieldType.outlined;
  LayerLink layerLink = LayerLink();
  bool _shouldFormat = true;
  bool _isFlagCircle = true;
  bool _showFlagInInput = true;
  bool _showArrow = true;
  late List<CountrySelectorNavigator> navigators;
  late CountrySelectorNavigator selectorNavigator;
  List<String> nameOfNavigators = [
    'Page',
    'Dialog',
    'Bottom Sheet',
    'Modal Bottom Sheet',
    'Draggable Bottom Sheet',
    'Dropdown',
  ];

  @override
  void initState() {
    super.initState();
    navigators = <CountrySelectorNavigator>[
      const CountrySelectorNavigator.searchDelegate(),
      const CountrySelectorNavigator.dialog(),
      const CountrySelectorNavigator.bottomSheet(),
      const CountrySelectorNavigator.modalBottomSheet(),
      const CountrySelectorNavigator.draggableBottomSheet(),
      CountrySelectorNavigator.dropdown(
        backgroundColor: const Color(0xFFE7DEF6),
        borderRadius: BorderRadius.circular(5),
        layerLink: layerLink,
        showSearchInput: true,
      ),
    ];
    selectorNavigator = navigators.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Phone form field demo')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 12),
              ConstrainedBox(
                constraints: const BoxConstraints(minWidth: double.infinity),
                child: SegmentedButton<FieldType>(
                  onSelectionChanged: (value) {
                    setState(() {
                      fieldType = value.first;
                    });
                  },
                  segments: const [
                    ButtonSegment<FieldType>(
                      value: FieldType.outlined,
                      label: Text("Outlined"),
                    ),
                    ButtonSegment<FieldType>(
                      value: FieldType.underlined,
                      label: Text("Underlined"),
                    ),
                  ],
                  selected: <FieldType>{fieldType},
                ),
              ),
              const SizedBox(height: 12),
              PhoneFormField(
                showArrow: _showArrow,
                shouldFormat: _shouldFormat,
                validator:
                    PhoneValidator.compose([PhoneValidator.required(), PhoneValidator.valid()]),
                isFlagCircle: _isFlagCircle,
                showFlagInInput: _showFlagInInput,
                decoration: InputDecoration(
                  labelText: 'Phone number',
                  border: switch (fieldType) {
                    FieldType.outlined => const OutlineInputBorder(),
                    FieldType.underlined => const UnderlineInputBorder(),
                  },
                ),
                countrySelectorNavigator: selectorNavigator,
              ),
              const SizedBox(height: 8),
              SwitchListTile(
                title: const Text('Should format'),
                value: _shouldFormat,
                onChanged: (bool value) {
                  setState(() {
                    _shouldFormat = value;
                  });
                },
              ),
              SwitchListTile(
                title: const Text('Circle flag'),
                value: _isFlagCircle,
                onChanged: (bool value) {
                  setState(() {
                    _isFlagCircle = value;
                  });
                },
              ),
              SwitchListTile(
                title: const Text('Show flag in input'),
                value: _showFlagInInput,
                onChanged: (bool value) {
                  setState(() {
                    _showFlagInInput = value;
                  });
                },
              ),
              SwitchListTile(
                title: const Text('Show arrow'),
                value: _showArrow,
                onChanged: (bool value) {
                  setState(() {
                    _showArrow = value;
                  });
                },
              ),
              ListTile(
                title: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    const Text('Country Selector'),
                    DropdownButton<CountrySelectorNavigator>(
                      value: selectorNavigator,
                      onChanged: (CountrySelectorNavigator? value) {
                        if (value != null) {
                          setState(() => selectorNavigator = value);
                        }
                      },
                      items: navigators
                          .asMap()
                          .entries
                          .map<DropdownMenuItem<CountrySelectorNavigator>>(
                        (entry) {
                          int index = entry.key;
                          CountrySelectorNavigator value = entry.value;
                          return DropdownMenuItem<CountrySelectorNavigator>(
                            value: value,
                            child: Text(nameOfNavigators[index]),
                          );
                        },
                      ).toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
