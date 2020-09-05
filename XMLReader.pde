class XMLReader {
  XML xml;
 
 XMLReader(String file) {
  try {
    xml = loadXML(file); 
  }catch (Exception e) {
   errorScreen(e); 
  }
 }
  
  XML getRandomString(String tag) {
    try{
      XML[] strings = xml.getChild(tag).getChildren("string");
      int stringArrayIndex = (int)random(0, strings.length);
      return strings[stringArrayIndex];
    }catch(Exception e) {
     return null;
    }
  }
  
  void changeXMLFile(String file) {
   xml = loadXML(file); 
  }
  
  String getAsString(String tag) {
   try{
     String tagString = xml.getChild(tag).getContent();
     return tagString;
   }catch(NullPointerException e) {
    print(e);
    return tag;
   }
  }
  
  String getStringContents(XML string) {
    try {
      return string.getChild("contents").getContent();
    }catch (Exception e) {
     return "INVALID_INDEX"; 
    }
  }
  
  int getStringSoundFile(XML string) {
    try {
      return Integer.parseInt(string.getChild("soundfile").getContent());
    }catch (Exception e) {
      return -1;
    }
  }
}
