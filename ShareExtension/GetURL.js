//Javascript file which extracts url and title of a webpage used by the shareViewController (extension)
//Javascript file is connected to shareViewController using a script written in the info.plist of shareViewController
var GetURL = function() {};
GetURL.prototype = {
    run: function(arguments) {
        arguments.completionFunction({"URL": document.URL,"title":document.title});
    }
};
var ExtensionPreprocessingJS = new GetURL;
