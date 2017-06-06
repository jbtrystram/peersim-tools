import java.io.FileInputStream;
import java.io.IOException;
import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.*;

public class BitpeerParser {

    public static void main(String[] args) throws IOException {

        // Prep
        List<String> output = new ArrayList<String>(Arrays.asList("Time Leechs Seeds Active"));

        long pid = new Random().nextInt(100);
        long logProgress = 0;
        int stepTime, active, leech, lineTime, seed;
        stepTime = active = leech = lineTime = seed = 0;

        FileInputStream inputStream = null;
        Scanner sc = null;
        try {
            inputStream = new FileInputStream(args[0]);
            sc = new Scanner(inputStream, "UTF-8");
            while (sc.hasNextLine()) {
                String line = sc.nextLine();
                logProgress++;

                if (line.startsWith("OBS")) {
                    //get timestamp
                    lineTime = Integer.parseInt(line.split(" ")[12]);

                    //Active peers
                    if (!line.split(" ")[8].contains("0") || !line.split(" ")[10].contains("0")) {
                        active++;
                    }
                    //count leechers and seeders
                    if ( lineTime == stepTime ){
                        if ( line.contains("(L)") ) ++leech;
                        else if ( line.contains("(S)") ) ++seed;
	                //total number of seeds & leech have been found, write them
                    } else {
                    output.add( String.valueOf(stepTime)+" "+String.valueOf(leech)+
                            " "+String.valueOf(seed)+" "+String.valueOf(active) );
                    stepTime = lineTime;
                    active = leech = seed = 0;

                    //log progress
                        if (logProgress % 10000 == 0) {
                            System.out.println("Processed line : " + logProgress);
                        }
                    }
                }
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

    // Write datafile
        Path dataFile = Paths.get("data"+pid);
        Files.write(dataFile, output, Charset.forName("UTF-8"));

    //write gnuplot script

        List<String> gnuplotCommands = Arrays.asList(
                "set terminal jpeg",
                "set output 'gnuplot2.jpg'",
        "set title ' Seeders / Leechers '",
        "set key invert reverse Left outside",
        "set key autotitle columnheader",
        "set xlabel ' Temps '",
        "set ylabel ' Total Peers '",
        "set boxwidth 1.25",
        "set style fill solid border -1 ",
        "set style histogram rowstacked",
        "set xtics autofreq 0, 10",

        "plot 'data"+pid+"' using 2 with histogram, using 3 with histogram, 'data"+
                pid+"' using 4 with lines lw 2 title 'Active Peers'");

        Path gnuplotFile = Paths.get("gnuplot"+pid);
        Files.write(gnuplotFile, gnuplotCommands, Charset.forName("UTF-8"));


//cleanup
 //       rm $TEMPFILE
 //       rm $GNUPLOT
    }
}
