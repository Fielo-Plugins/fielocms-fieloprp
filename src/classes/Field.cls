/**
 * @brief      Clase wrapper con toda la informacion de un campo agregado en un fieldset de un componente para ser mostrado en Front End
 * @details    Contiene datos relacionados con atributos propios de un campo, atributos de un subcomponente, multi language, visibilidad y seguridad
 */
global class Field implements Comparable{
/** Common Attributes **/
    global String apiName { get {
        return (String) attributes.get('apiName');
    } set;}

    public String label { get {
        return (String) attributes.get('label');
    } set;}

    public String type { get {
        return (String) attributes.get('type');
    } set;}

    public Boolean showLabel { get {
        if ( !attributes.containsKey('showLabel') ) {
            return true;
        }
        return (Boolean)attributes.get('showLabel');
    } set;}
 

    global Map<String,Object> attributes {get;set;}

    public String attributesJSON {get {
            return JSON.serialize(this.attributes);
            // return '{ "apiName" : "' + apiName + '", "label" : "' + label + '", "type" : "' + type + '"}';
        }
    }

    public Boolean multiLanguage { get {
        return false;
        if ( !attributes.containsKey('multiLanguage') ) return false;
        return (Boolean) attributes.get('multiLanguage');
    } set;}

/*
* Constructor desde el JSON deserealizado
* El constructor esta pensado para ser usado cuando crea un field de tipo subcomponent leyendo un fieldset en formato json
*/
    public Field ( Map<String,Object> mapValues ) {
    // Chequea que tenga los atributos basicos
        if ( !mapValues.containsKey('apiName') || !mapValues.containsKey('label') || !mapValues.containsKey('type') ) {
            throw new FieloPLT.FieloException( 'Field must have apiName, label & type' );
        }
        this.attributes = mapValues;
        if ( !this.attributes.containsKey('showLabel') ) {
            attributes.put( 'showLabel', true);        
        }
    }

/*
* Constructor desde el JSON deserealizado
* El constructor esta pensado para ser usado cuando crea un field de tipo campo leyendo un fieldset en formato json y eld describe del campo
*/
    public Field ( Map<String,Object> mapValues , DescribeFieldResult fieldDescribe ) {
    // Chequea que tenga los atributos basicos
        if ( !mapValues.containsKey('apiName') || !mapValues.containsKey('label') || !mapValues.containsKey('type') ) {
            throw new FieloPLT.FieloException( 'Field must have apiName, label & type' );
        }
        attributes = mapValues;

    // Hace un override de valores en caso no cumplan con las restricciones del modelo de datos
        if ( fieldDescribe.isCalculated() ) {
            attributes.put( 'readOnly', true );
        } 
        if ( !fieldDescribe.isNillable() ) {
            attributes.put( 'required', true );
        }
    // Agrega los atributos propios del campo que pueden ser usados        
        if ( fieldDescribe.getInlineHelpText() != null ) {
            attributes.put( 'inlineHelpText', fieldDescribe.getInlineHelpText() );
        } else {
            attributes.put( 'inlineHelpText', '');
        }
        attributes.put( 'maxLength', fieldDescribe.getLength() );
        attributes.put( 'defaultValue', fieldDescribe.getDefaultValueFormula() );

        if ( this.type == 'Picklist' ) {
            List<SelectOption> pickListValues = new List<SelectOption>{new SelectOption('', '--' + System.Label.FieloCMS.None + '--')};
            for(Schema.PicklistEntry pick : fieldDescribe.getPicklistValues()){
                pickListValues.add(new SelectOption(pick.getValue(), pick.getLabel()));
            } 
            attributes.put( 'picklistValues', pickListValues );
        }
    }
/*
* Constructor desde un Describe de un Field de un Objeto
* El constructor esta pensado para ser usado cuando se agrega un campo a un Fieldset.
* Como es la primera vez toma los datos por defecto del describe
*/
    public Field ( DescribeFieldResult fieldDescribe, String fieldType ) {
        attributes = new Map<String,Object>();
    // atributos basicos
        attributes.put( 'type', fieldDescribe.getType() );
        attributes.put( 'apiName', fieldDescribe.getName() );
        attributes.put( 'label', fieldDescribe.getLabel() );
        attributes.put( 'showLabel', true);
    // atributos particulares de los fields
        if ( fieldType == 'List' ) {
            attributes.put( 'orderBy', 'disabled');            
            attributes.put( 'linkToDetail', fieldDescribe.isNameField() );             
        } else if ( fieldType == 'Record-Edit' ) {
            attributes.put( 'autocomplete', '' );
            attributes.put( 'placeholder', '');
            attributes.put( 'inlineHelpText', '');
            attributes.put( 'readOnly', fieldDescribe.isCalculated() );
            attributes.put( 'required', !fieldDescribe.isNillable() );
        }
    }


// Metodos para hacer sort en las listas
    public Integer compareTo(Object compareTo) {
        FIeld compareToItem = (FIeld) compareTo;
        Integer ret = 0;
        if(this.label == compareToItem.label){
            ret = 0;
        }
        if(this.label > compareToItem.label){
            ret = 1;
        }
        if(this.label < compareToItem.label){
            ret = -1;
        }
        return ret;
    }

    public Boolean equals(Field fieldItem){
        return this.apiName == fieldItem.apiName && this.type == fieldItem.type && this.label == fieldItem.label;
    }

    public Integer hashCode() {
        Integer ret = 0;
        if(this.apiName != null){
            ret = this.apiName.hashCode();
        }else if(this.type != null){
            ret = this.type.hashCode();
        }else{
            ret = this.label.hashCode();
        }
        return ret;
    }
}