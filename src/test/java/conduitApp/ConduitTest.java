package conduitApp;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;
import com.intuit.karate.junit5.Karate;
import com.intuit.karate.KarateOptions;

@KarateOptions(tags={"@debug"} )
class ConduitTest {

    @Test
    void testParallel() {
        Results results = Runner.path("classpath:conduitApp/feature")
                .tags("~@ignore")
                //.outputCucumberJson(true)
                .parallel(5);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

    // @Karate.Test
    // Karate testTags() {
    //     return Karate.run().tags("@debug").relativeTo(getClass());
    // }

}
