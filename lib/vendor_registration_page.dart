import 'package:flutter/material.dart';
import 'package:flutter_highland/constants/color_constant.dart';

class VendorRegistrationPage extends StatefulWidget {
  @override
  _VendorRegistrationPageState createState() => _VendorRegistrationPageState();
}

class _VendorRegistrationPageState extends State<VendorRegistrationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<Map<String, dynamic>> _products = [];
  final TextEditingController _productController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  void _addProduct() {
    if (_productController.text.isNotEmpty &&
        _priceController.text.isNotEmpty) {
      setState(() {
        _products.add({
          'product': _productController.text,
          'price': double.parse(_priceController.text),
        });
        _productController.clear();
        _priceController.clear();
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Submit the form data
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Vendor Registration Submitted Successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vendor Registration'),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.blue[50]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Vendor Registration",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                const SizedBox(height: 20),
                _buildCard(
                  title: "Vendor Details",
                  child: Column(
                    children: [
                      _buildRow(label: 'Department', widget: _buildDropdown()),
                      const SizedBox(height: 15),
                      _buildRow(
                          label: 'ID', widget: _buildTextField(hint: '123')),
                      const SizedBox(height: 15),
                      _buildRow(
                          label: 'Name',
                          widget: _buildTextField(hint: 'Organisation Name')),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                _buildCard(
                  title: "Address Details",
                  child: Column(
                    children: [
                      _buildRow(
                          label: 'City',
                          widget: _buildTextField(hint: 'City Name')),
                      const SizedBox(height: 15),
                      _buildRow(
                          label: 'State',
                          widget: _buildTextField(hint: 'State Name')),
                      const SizedBox(height: 15),
                      _buildRow(
                          label: 'Phone',
                          widget: _buildTextField(
                              hint: '123-4567890',
                              keyboardType: TextInputType.phone)),
                      const SizedBox(height: 15),
                      _buildRow(
                          label: 'Mobile',
                          widget: _buildTextField(
                              hint: '9876543210',
                              keyboardType: TextInputType.phone)),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                _buildCard(
                  title: "Tax Details",
                  child: Column(
                    children: [
                      _buildRow(
                          label: 'CGST (%)',
                          widget: _buildTextField(
                              hint: '0.0', keyboardType: TextInputType.number)),
                      const SizedBox(height: 15),
                      _buildRow(
                          label: 'SGST (%)',
                          widget: _buildTextField(
                              hint: '0.0', keyboardType: TextInputType.number)),
                      const SizedBox(height: 15),
                      _buildRow(
                          label: 'IGST (%)',
                          widget: _buildTextField(
                              hint: '0.0', keyboardType: TextInputType.number)),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                _buildCard(
                  title: "Products and Pricing",
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                                controller: _productController,
                                hint: 'Product Name'),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _buildTextField(
                                controller: _priceController,
                                hint: 'Price',
                                keyboardType: TextInputType.number),
                          ),
                          IconButton(
                            icon: Icon(Icons.add, color: Colors.teal),
                            onPressed: _addProduct,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      _products.isNotEmpty
                          ? Column(
                              children: _products
                                  .map(
                                    (product) => ListTile(
                                      title: Text(product['product']),
                                      trailing:
                                          Text('\u20B9 ${product['price']}'),
                                    ),
                                  )
                                  .toList(),
                            )
                          : Text(
                              'No products added yet',
                              style: TextStyle(color: Colors.grey),
                            ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text(
                    "Upload docs",
                    style: TextStyle(color: ColorConstant.mainBlack),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstant.lightOrange,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    textStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    child: Text(
                      "Submit",
                      style: TextStyle(color: ColorConstant.mainWhite),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding:
                          EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      textStyle:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard({required String title, required Widget child}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal),
            ),
            const SizedBox(height: 10),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildRow({required String label, required Widget widget}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            '$label:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: widget,
        ),
      ],
    );
  }

  Widget _buildTextField({
    String? hint,
    TextInputType keyboardType = TextInputType.text,
    TextEditingController? controller,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(),
      ),
      keyboardType: keyboardType,
      validator: (value) =>
          value!.isEmpty ? 'This field cannot be empty' : null,
    );
  }

  Widget _buildDropdown() {
    return DropdownButtonFormField<String>(
      items: ['Pharmacy', 'Lab', 'OT', 'Stationary']
          .map((dept) => DropdownMenuItem(
                value: dept,
                child: Text(dept),
              ))
          .toList(),
      onChanged: (value) {},
      decoration: InputDecoration(
        border: OutlineInputBorder(),
      ),
    );
  }
}
