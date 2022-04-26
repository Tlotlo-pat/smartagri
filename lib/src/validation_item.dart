class ValidationItem {
  final dynamic value;
  final String? error;

  ValidationItem(this.value, this.error);

  bool isValid(){
    return error == null && value!=null;
  }
}