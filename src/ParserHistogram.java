//launch : Java ParserHistogram fileToParse

import java.io.FileInputStream;
import java.io.IOException;
import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.*;

public class ParserHistogram {

    public static void main(String[] args) throws IOException {

        // Prep
        int nodeProgress = 0;
        int nodeProgress2[] = new int[11];

        FileInputStream inputStream = null;
        Scanner sc = null;
        Scanner scFinalLine = null;

        try {
            //looking for the final line of the file to get maxTime
            inputStream = new FileInputStream(args[0]);
            scFinalLine = new Scanner(inputStream, "UTF-8");
            String finalLine, maxTime;
            finalLine = maxTime = "";
            while (scFinalLine.hasNextLine()) {
              finalLine = scFinalLine.nextLine();
            }
            int maxTimeInt = Integer.parseInt(finalLine.split(" ")[0]);
            maxTime = String.valueOf(maxTimeInt);
            scFinalLine.close();

            //parsing
            inputStream = new FileInputStream(args[0]);
            sc = new Scanner(inputStream, "UTF-8");
            while (sc.hasNextLine()) {
                String line = sc.nextLine();

                if (line.startsWith(maxTime)) {
                  nodeProgress = Integer.parseInt(line.split(" ")[3]);

                  if (nodeProgress < 0.1*390) {
                    nodeProgress2[0]++;
                  } else if (nodeProgress < 0.2*390) {
                    nodeProgress2[1]++;
                  } else if (nodeProgress < 0.3*390) {
                    nodeProgress2[2]++;
                  } else if (nodeProgress < 0.4*390) {
                    nodeProgress2[3]++;
                  } else if (nodeProgress < 0.5*390) {
                    nodeProgress2[4]++;
                  } else if (nodeProgress < 0.6*390) {
                    nodeProgress2[5]++;
                  } else if (nodeProgress < 0.7*390) {
                    nodeProgress2[6]++;
                  } else if (nodeProgress < 0.8*390) {
                    nodeProgress2[7]++;
                  } else if (nodeProgress < 0.9*390) {
                    nodeProgress2[8]++;
                  } else if (nodeProgress < 390) {
                    nodeProgress2[9]++;
                  } else if (nodeProgress == 390) {
                    nodeProgress2[10]++;
                  }
                }
            }

            for (int j=0; j<=10 ; j++ ) {
              System.out.println( 5+j*10 + " " + String.valueOf(nodeProgress2[j]) );
            }

            // note that Scanner suppresses exceptions
            if (sc.ioException() != null) {
                throw sc.ioException();
            }
        } finally {
            if (inputStream != null) {
                inputStream.close();
            }
            if (sc != null) {
                sc.close();
            }
        }

    //write gnuplot script
    List<String> gnuplotCommands = Arrays.asList(
    "set title 'Progress in the end'",
    "set label 'File complete in " + nodeProgress2[10] + " nodes' at graph 0.5,0.9 center font 'Verdana,20'",
    "set xrange [0:100]",
    "set yrange [0:500]",
    "plot 'data' with boxes linecolor rgb '#2730AE'");

    Path gnuplotFile = Paths.get("../output/scripts/histogram/gnuplot");
    Files.write(gnuplotFile, gnuplotCommands, Charset.forName("UTF-8"));

    }
}
