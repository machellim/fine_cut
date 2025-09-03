enum AppActiveStatus { active, inactive }

enum CashRegisterStatus { open, closed }

enum RecordStatus { active, deleted }

/// Defines the context from which an action is executed in the app.
/// Mainly used to identify the origin of an event, such as when
/// loading data after certain operations.
enum AppEventSource {
  /// Executed from the main list view.
  list,

  /// Executed after creating a new record.
  create,

  /// Executed after updating an existing record.
  update,

  delete,
}

/// Enum to represent the action type when creating or updating a record
enum RecordAction {
  /// Represents creating a new record
  create,

  /// Represents updating an existing record
  update,
}
