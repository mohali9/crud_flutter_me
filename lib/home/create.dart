import 'package:crud_flutter_me/api/api_service.dart';
import 'package:crud_flutter_me/model/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class FormAddScreen extends StatefulWidget {
  // var
  Profile profile;
  FormAddScreen({this.profile});

  @override
  _FormAddScreenState createState() => _FormAddScreenState();
}

class _FormAddScreenState extends State<FormAddScreen> {
  bool _isLoading = false;
  ApiService _apiService = ApiService();
  bool _isFieldtitleValid;
  bool _isFielddescriptionValid;
  bool _isFieldfileValid;
  bool _isFieldimageValid;
  TextEditingController _controllertitle = TextEditingController();
  TextEditingController _controllerdescription = TextEditingController();
  TextEditingController _controllerfile = TextEditingController();
  TextEditingController _controllerimage = TextEditingController();

  @override
  //deklarasi method initState()
  void initState() {
    if (widget.profile != null) {
      _isFieldtitleValid = true;
      _controllertitle.text = widget.profile.title;
      _controllerdescription.text = widget.profile.description;
      _controllerfile.text = widget.profile.file;
      _controllerimage.text = widget.profile.image;
      // _isFieldAgeValid = true;
      // _controllerAge.text = widget.profile.age.toString();
    }
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          // ubah title appbar
          widget.profile == null ? "Form Add" : "Change Data",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildTextFieldtitle(),
                _buildTextFielddescription(),
                _buildTextFieldfile(),
                _buildTextFieldimage(),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: RaisedButton(
                    child: Text(
                      widget.profile == null
                          ? "Submit".toUpperCase()
                          : "Update Data".toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      if (_isFieldtitleValid == null ||
                          _isFielddescriptionValid == null ||
                          _isFieldfileValid == null ||
                          _isFieldimageValid == null ||
                          !_isFieldtitleValid ||
                          !_isFielddescriptionValid ||
                          !_isFieldfileValid ||
                          !_isFieldimageValid) {
                        _scaffoldState.currentState.showSnackBar(
                          SnackBar(
                            content: Text("Please fill all field"),
                          ),
                        );
                        return;
                      }
                      setState(() => _isLoading = true);
                      String title = _controllertitle.text.toString();
                      String description =
                          _controllerdescription.text.toString();
                      String file = _controllerfile.text.toString();
                      String image = _controllerimage.text.toString();
                      // int age = int.parse(_controllerAge.text.toString());
                      Profile profile = Profile(
                          title: title,
                          description: description,
                          file: file,
                          image: image);
                      if (widget.profile == null) {
                        _apiService.createProfile(profile).then((isSuccess) {
                          setState(() => _isLoading = false);
                          if (isSuccess) {
                            _scaffoldState.currentState.showSnackBar(
                              SnackBar(
                                content: Text("Submit data failed"),
                              ),
                            );
                          } else {
                            Navigator.pop(_scaffoldState.currentState.context);
                          }
                        });
                      } else {
                        profile.id = widget.profile.id;
                        _apiService.updateProfile(profile).then((isSuccess) {
                          setState(() => _isLoading = false);
                          if (isSuccess) {
                            Navigator.pop(_scaffoldState.currentState.context);
                          } else {
                            _scaffoldState.currentState.showSnackBar(SnackBar(
                              content: Text("Update data failed"),
                            ));
                          }
                        });
                      }
                    },
                    color: Colors.orange[600],
                  ),
                )
              ],
            ),
          ),
          _isLoading
              ? Stack(
                  children: <Widget>[
                    Opacity(
                      opacity: 0.3,
                      child: ModalBarrier(
                        dismissible: false,
                        color: Colors.grey,
                      ),
                    ),
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _buildTextFieldtitle() {
    return TextField(
      controller: _controllertitle,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Title",
        errorText: _isFieldtitleValid == null || _isFieldtitleValid
            ? null
            : "Full Title is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldtitleValid) {
          setState(() => _isFieldtitleValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFielddescription() {
    return TextField(
      controller: _controllerdescription,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Description",
        errorText: _isFielddescriptionValid == null || _isFielddescriptionValid
            ? null
            : "Description is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFielddescriptionValid) {
          setState(() => _isFielddescriptionValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldfile() {
    return TextField(
      controller: _controllerfile,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "File",
        errorText: _isFieldfileValid == null || _isFieldfileValid
            ? null
            : "File is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldfileValid) {
          setState(() => _isFieldfileValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldimage() {
    return TextField(
      controller: _controllerimage,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Image",
        errorText: _isFieldimageValid == null || _isFieldimageValid
            ? null
            : "Image is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldimageValid) {
          setState(() => _isFieldimageValid = isFieldValid);
        }
      },
    );
  }
}
