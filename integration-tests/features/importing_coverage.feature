Feature: Importing coverage data
  As a SonarQube user,
  I want to import my coverage metric values into SonarQube
  In order to be able to use relevant SonarQube features

  @SqApi56
  Scenario: Importing coverage reports
    Given the project "coverage_project"
    When I run sonar-scanner with following options:
      """
      -Dsonar.cxx.coverage.reportPath=ut-coverage.xml
      -Dsonar.cxx.coverage.itReportPath=it-coverage.xml
      -Dsonar.cxx.coverage.overallReportPath=overall-coverage.xml
      -Dsonar.cxx.coverage.forceZeroCoverage=False
      """
    Then the analysis finishes successfully
    And the analysis in server has completed
    And the analysis log contains no error/warning messages except those matching:
      """
      .*WARN.*Unable to get a valid mac address, will use a dummy address
      .*WARN.*cannot find the sources for '#include <iostream>'
      """
    And the following metrics have following values:
      | metric                  | value |
      | coverage                | 23.8  |
      | line_coverage           | 17.6  |
      | branch_coverage         | 50    |
      | it_coverage             | 40.6  |
      | it_line_coverage        | 36.4  |
      | it_branch_coverage      | 50    |
      | overall_coverage        | 34.0  |
      | overall_line_coverage   | 28.2  |
      | overall_branch_coverage | 50.0  |

  @SqApi62
  Scenario: Importing coverage reports
    Given the project "coverage_project"
    When I run sonar-scanner with following options:
      """
      -Dsonar.cxx.coverage.reportPath=ut-coverage.xml
      -Dsonar.cxx.coverage.itReportPath=it-coverage.xml
      -Dsonar.cxx.coverage.overallReportPath=overall-coverage.xml
      """
    Then the analysis finishes successfully
    And the analysis in server has completed
    And the analysis log contains no error/warning messages except those matching:
      """
      .*WARN.*Unable to get a valid mac address, will use a dummy address
      .*WARN.*cannot find the sources for '#include <iostream>'
      """
    And the following metrics have following values:
      | metric                  | value |
      | coverage                | 31.0  |
      | line_coverage           | 25.0  |
      | branch_coverage         | 50    |

  @SqApi56
  Scenario: Importing coverage reports zeroing coverage for untouched files
    Given the project "coverage_project"
    When I run sonar-scanner with following options:
      """
      -Dsonar.cxx.coverage.reportPath=ut-coverage.xml
      -Dsonar.cxx.coverage.itReportPath=it-coverage.xml
      -Dsonar.cxx.coverage.overallReportPath=overall-coverage.xml
      -Dsonar.cxx.coverage.forceZeroCoverage=True
      """
    Then the analysis finishes successfully
    And the analysis in server has completed
    And the analysis log contains no error/warning messages except those matching:
      """
      .*WARN.*Unable to get a valid mac address, will use a dummy address
      .*WARN.*cannot find the sources for '#include <iostream>'
      """
    And the following metrics have following values:
      | metric                  | value |
      | coverage                | 11.1  |
      | line_coverage           | 7.3   |
      | branch_coverage         | 50    |
      | it_coverage             | 25.0  |
      | it_line_coverage        | 19.0  |
      | it_branch_coverage      | 50    |
      | overall_coverage        | 26.1  |
      | overall_line_coverage   | 20.0  |
      | overall_branch_coverage | 50    |

  @SqApi56
  Scenario: Zeroing coverage measures without importing reports
    If we don't pass coverage reports *and* request zeroing untouched
    files at the same time, all coverage measures, except the branch
    ones, should be 'zero'. The branch coverage measures remain 'None',
    since its currently ignored by the 'force zero...'
    implementation
    Given the project "coverage_project"
    When I run sonar-scanner with following options:
      """
      -Dsonar.cxx.coverage.reportPath=dummy.xml
      -Dsonar.cxx.coverage.itReportPath=dummy.xml
      -Dsonar.cxx.coverage.overallReportPath=dummy.xml
      -Dsonar.cxx.coverage.forceZeroCoverage=True
      """
    Then the analysis finishes successfully
    And the analysis in server has completed
    And the analysis log contains no error/warning messages except those matching:
      """
      .*WARN.*Unable to get a valid mac address, will use a dummy address
      .*WARN.*cannot find the sources for '#include <iostream>'
      .*WARN.*Cannot find a report for '.*'
      """
    And the following metrics have following values:
      | metric                  | value |
      | coverage                | 0     |
      | line_coverage           | 0     |
      | branch_coverage         | None  |
      | it_coverage             | 0     |
      | it_line_coverage        | 0     |
      | it_branch_coverage      | None  |
      | overall_coverage        | 0     |
      | overall_line_coverage   | 0     |
      | overall_branch_coverage | None  |

  @SqApi62
  Scenario: Zero coverage measures without coverage reports
    If we don't pass coverage reports all coverage measures, except the branch
    ones, should be 'zero'. The branch coverage measures remain 'None'
    Given the project "coverage_project"
    When I run sonar-scanner with following options:
      """
      -Dsonar.cxx.coverage.reportPath=dummy.xml
      -Dsonar.cxx.coverage.itReportPath=dummy.xml
      -Dsonar.cxx.coverage.overallReportPath=dummy.xml
      """
    Then the analysis finishes successfully
    And the analysis in server has completed
    And the analysis log contains no error/warning messages except those matching:
      """
      .*WARN.*Unable to get a valid mac address, will use a dummy address
      .*WARN.*cannot find the sources for '#include <iostream>'
      .*WARN.*Cannot find a report for '.*'
      """
    And the following metrics have following values:
      | metric                  | value |
      | coverage                | 0     |
      | line_coverage           | 0     |
      | branch_coverage         | None  |
