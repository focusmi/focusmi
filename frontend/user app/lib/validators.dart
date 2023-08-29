class Validators {
    // value - value to be validated, label - label in the validation message
    checkNull(value){
      if(value==null || value.isEmpty){
        return true;
      }
      else{
       return false;
      }  
    }

    checkRegex(value, regex){
        RegExp reg = RegExp(regex);
        if(!reg.hasMatch(value)){
          return false;
        }
        else{
          return true;
        }

    }
}