class FormValidators {
  static String? validateEmail(String value) {
    // Remove leading and trailing whitespace from the email address.
    value = value.trim();

    // Check if the email address is not empty.
    if (value.isEmpty) {
      return 'Please enter an email address';
    }

    // Check for the presence of "@" symbol.
    if (!value.contains('@')) {
      return 'Please enter a valid email address';
    }

    // Check the format of the email address.
    final emailParts = value.split('@');
    if (emailParts.length != 2 ||
        emailParts[0].isEmpty ||
        emailParts[1].isEmpty) {
      return 'Please enter a valid email address';
    }

    // Check for valid domain part (part after "@" symbol).
    // You may use additional checks, like verifying DNS records, to ensure the domain exists.
    final domainParts = emailParts[1].split('.');
    if (domainParts.length < 2 || domainParts.last.length < 2) {
      return 'Please enter a valid email address';
    }

    // Check for valid top-level domain (TLD).
    // You can customize this list based on the recognized TLDs in your application.
    const validTLDs = ['com', 'org', 'net']; // Without the dot.
    if (!validTLDs.contains(domainParts.last.toLowerCase())) {
      return 'Please enter a valid email address';
    }

    // Check the length of the entire email address.
    const maxLength = 100; // Customize the maximum length as needed.
    if (value.length > maxLength) {
      return 'Email address is too long';
    }

    return null; // Return null if the email address is valid.
  }

  static String? validateFullName(String value) {
    if (value.isEmpty) {
      return 'Please enter your full name';
    }

    // Check if both first name and last name are provided.
    final nameParts = value.trim().split(' ');
    if (nameParts.length < 2) {
      return 'Please enter both first name and last name';
    }

    // Check minimum and maximum length of the full name.
    const minLength = 3;
    const maxLength = 50;
    if (value.length < minLength || value.length > maxLength) {
      return 'Full name should be between $minLength and $maxLength characters long';
    }

    // Check if the name contains only alphabetic characters, spaces, and hyphens.
    if (!RegExp(r'^[a-zA-Z \-]+$').hasMatch(value)) {
      return 'Please enter a valid full name';
    }

    // Check for numeric digits.
    if (RegExp(r'\d').hasMatch(value)) {
      return 'Full name should not contain numbers';
    }

    // Check for excessive spaces.
    if (RegExp(r'\s{2,}').hasMatch(value)) {
      return 'Please avoid excessive spaces in the full name';
    }

    // Check for proper capitalization.
    if (!value.split(' ').every((part) => part[0].toUpperCase() == part[0])) {
      return 'Please capitalize the first letter of each name part';
    }

    return null; // Return null if the full name is valid.
  }

  static String? validateEmptyEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email address';
    }
    return null;
  }
  static String? validateEmptyPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }
}
