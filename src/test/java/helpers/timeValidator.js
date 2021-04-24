function fn(s) {
    var simpleDateFormat = Java.type("java.text.SimpleDateFormat");
    var sdf = new simpleDateFormat("yyy-MM-dd'T'HH:mm:ss.ms'Z'");
    try{
        sdf.parse(s).time;
        return true;
    }catch(e){
        karate.log("*** invalid date string:",s);
        return false;
    }
}