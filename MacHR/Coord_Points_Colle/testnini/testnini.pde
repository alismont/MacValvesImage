//launch("Test.bat");
//Runtime rt = Runtime.getRuntime();
import java.io.*;
///public static Process exec("gphoto2", "--trigger-capture"); 
//exec("ping", "192.168.1.1");
//exec("gphoto2", "--trigger-capture");
Process p = exec("gphoto2", "--trigger-capture");
//Process p = Runtime.getRuntime().exec("gphoto2", "--trigger-capture");

try {
  int result = p.waitFor();
  println(result);
}catch(InterruptedException e){e.printStackTrace();
}//catch(IOException e){e.printStackTrace();
//}
