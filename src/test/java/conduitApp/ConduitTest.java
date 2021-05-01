package conduitApp;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import static org.junit.jupiter.api.Assertions.*;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.apache.commons.io.FileUtils;
import org.junit.jupiter.api.Test;

// Run karate test  :   mvn clean test -Dkarate.options="--tags @debug" -Dkarate.env="dev"
// Run Gatling test :   mvn clean test-compile gatling:test

class ConduitTest {

    @Test
    void testParallel() {
        Results results = Runner.path("classpath:conduitApp/feature")
                .tags("~@ignore")
                .outputCucumberJson(true)
                .parallel(1);
        
        generateReport(results.getReportDir());

        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

    // @Karate.Test
    // Karate testTags() {
    //     return Karate.run().tags("@debug").relativeTo(getClass());
    // }

    public static void generateReport(String karateOutputPath) {        
        Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[] {"json"}, true);
        List<String> jsonPaths = new ArrayList<String>(jsonFiles.size());
        jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
        Configuration config = new Configuration(new File("target"), "Conduit App");
        ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
        reportBuilder.generateReports();        
    }

}
