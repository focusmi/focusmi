class Validators {
    // value - value to be validated, label - label in the validation message
    checkNull(value, label){
      if(value == null || value.isEmpty()){
        return "Please enter the {$label}";
      }
    }

    checkRegex(value, regex, message){
        RegExp reg = RegExp(regex);
        if(!reg.hasMatch(value)){
          return false;
        }
        else{
          return true;
        }

    }
}