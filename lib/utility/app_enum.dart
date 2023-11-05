enum Designation {
  productDesigner('Product Designer'),
  flutterDeveloper('Flutter Developer'),
  qaTester('QA Tester'),
  productOwner('Product Owner'),
  none('Select Role');

  factory Designation.fromString(String? value) {
    switch (value?.toLowerCase()) {
      case 'productdesigner':
        return productDesigner;
      case 'flutterdeveloper':
        return flutterDeveloper;
      case 'qatester':
        return qaTester;
      case 'productowner':
        return productOwner;
      default:
        return none;
    }
  }

  const Designation(this.label);

  final String label;
}

enum CrudOperation {
  create,
  update,
  delete;

  factory CrudOperation.fromString(String? value) {
    switch (value?.toLowerCase()) {
      case 'create':
        return create;
      case 'update':
        return update;
      case 'delete':
        return delete;
      default:
        return create;
    }
  }
}
