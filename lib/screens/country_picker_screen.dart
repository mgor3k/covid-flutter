import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/country.dart';
import '../styles.dart';

import '../widgets/searchbar.dart';
import '../widgets/country_cell.dart';

import '../providers/country_picker_provider.dart';

class CountryPickerScreen extends StatefulWidget {
  @override
  _CountryPickerScreenState createState() => _CountryPickerScreenState();
}

class _CountryPickerScreenState extends State<CountryPickerScreen> {
  TextEditingController _controller;
  FocusNode _focusNode;

  bool _isSearching = false;
  bool _isLoading = true;

  List<Country> _items = [];
  List<Country> _filteredItems = [];

  List<Country> get _currentItems {
    return _isSearching ? _filteredItems : _items;
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController()..addListener(_onTextChanged);
    _focusNode = FocusNode();
    _fetchCountries();
  }

  void _fetchCountries() {
    _isLoading = true;
    final provider = Provider.of<CountryPickerProvider>(context, listen: false);
    provider.fetchCountries().catchError((error) {
      return showError(error).then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }).then((items) {
      setState(() {
        _items = items;
        _isLoading = false;
      });
    });
  }

  Future<void> showError(Exception error) async {
    await showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: Text('Error'),
        content: Text(error.toString()),
        actions: [
          FlatButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  void _onTextChanged() {
    setState(() {
      final text = _controller.text;
      _isSearching = text.isNotEmpty;
      _filteredItems = _items
          .where(
              (item) => item.country.toLowerCase().contains(text.toLowerCase()))
          .toList();
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  Widget _buildSearchBox() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SearchBar(
        controller: _controller,
        focusNode: _focusNode,
      ),
    );
  }

  void _onTapped(Country country) {
    print('tapped ${country.country}');
    final provider = Provider.of<CountryPickerProvider>(context, listen: false);
    provider.pickCountry(country);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: NestedScrollView(
        headerSliverBuilder: (ctx, isScrolled) {
          return [
            CupertinoSliverNavigationBar(
              backgroundColor: Colors.white,
              border: null,
              largeTitle: Text('Select a country'),
            ),
          ];
        },
        body: Column(
          children: [
            _buildSearchBox(),
            Expanded(
              child: Container(
                decoration: BoxDecoration(color: Styles.searchBackground),
                child: _isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Scrollbar(
                        child: ListView.builder(
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          itemCount:
                              _currentItems == null ? 0 : _currentItems.length,
                          itemBuilder: (ctx, index) => CountryCell(
                            title: _currentItems[index].country,
                            isFirst: index == 0,
                            isLast: index + 1 == _currentItems.length,
                            onTapped: () {
                              _onTapped(_currentItems[index]);
                            },
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 24,
                            horizontal: 16,
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
