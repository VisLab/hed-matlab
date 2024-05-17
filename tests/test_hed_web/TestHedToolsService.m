classdef TestHedToolsService < matlab.unittest.TestCase

    properties
       hcon
    end

    methods (TestClassSetup)
        function setConnection(testCase)
            testCase.hcon = ...
                HedToolsService('8.2.0', 'http://127.0.0.1:5000');
        end
    end

    methods (Test)

        function testCreateConnection(testCase)
            % Test a simple string
            hed = HedToolsService('8.2.0', 'https://hedtools.org/hed_dev');
            testCase.verifyTrue(isa(hed, 'HedToolsService'));   
        end
            
        function testValidString(testCase)
            % Test valid check warnings no warnings
            issues = testCase.hcon.validate_hedtags('Red, Blue', true);
            testCase.verifyEqual(strlength(issues), 0);
            
            % Test valid check warnings has warnings
            issues = testCase.hcon.validate_hedtags('Red, Blue/Apple', ...
                true);
            testCase.verifyGreaterThan(strlength(issues), 0);

            % Test valid no check warnings has warnings
            issues = testCase.hcon.validate_hedtags('Red, Blue/Apple', ...
                false);
            testCase.verifyEqual(strlength(issues), 0);

            % Test with extension and no check warnings
            issues = testCase.hcon.validate_hedtags('Red, Blue/Apple', ...
                false);
            testCase.verifyEqual(strlength(issues), 0, ...
                'Valid HED string with ext has no errors.');
        end


        function testInvalidString(testCase)
            % Test check warnings with errors
            issues1 = testCase.hcon.validate_hedtags(...
                 'Red, Blue/Apple, Green, Blech', true);
            testCase.verifyGreaterThan(strlength(issues1), 0);
            
            % Test no check warnings with errors
            issues2 = testCase.hcon.validate_hedtags(...
                 'Red, Blue/Apple, Green, Blech', false);
            testCase.verifyGreaterThan(strlength(issues2), 0);
        end


        function testInvalidFormatStrings(testCase)
            % Test pass cell array (should only take strings)
            testCase.verifyError(@() testCase.hcon.validate_hedtags( ...
                {'Red, Blue/Apple', 'Green, Blech'}, true), ...
                'HedToolsService:validate_hedtags');
            testCase.verifyError(@() testCase.hcon.validate_hedtags( ...
                {'Red, Blue/Apple', 'Green, Blech'}, false), ...
                'HedToolsService:validate_hedtags');
        end


        % % Todo: test with and without schema
        % Todo: test with definitions

    end
end