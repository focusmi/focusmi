

function insertValue(json,target,targetvalue,label,labelvalue){
    json.forEach(element => {
        if(element[target]==targetvalue){
            element[label] = labelvalue
        }
    });

}
 
function joinJson(json1, json2, target,label,sendval){
    json2.forEach(element => {
        insertValue(json1,target,element[target],label,element[sendval])    
    });
    return json1;
}


module.exports = {
    insertValue,
    joinJson
}

