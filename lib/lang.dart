final RegExp idRegex = RegExp(r"^[a-zA-Z0-9_-]+$");

const String appName = "BlueMap Marker Generator";

const String cancel = "Cancel";
const String add = "Add";

//Properties
//  Shared
const String propertyID = "ID";
const String propertyLabel = "Label";
//  Marker Set
//  Marker Base
const String propertyPosition = "Position";
//  Marker Poi
//  Marker Line
const String propertyLine = "Line";

//Text field error hints
const String cannotBeEmpty = "Can't be empty";
const String noDuplicateIDs = "Can't have a duplicate ID";
const String invalidCharacter = "Invalid character";

//Load Save Buttons
const String loadButtonTooltip = "Load Marker Set (Ctrl+O)";
const String saveButtonTooltip = "Save Marker Set (Ctrl+S)";

//Usage Information Dialog
const String usageInformationTitle = "Usage Information";
const String usageInformationDoNotShowAgain = "Don't show again this session";
const String usageInformationUnderstood = "Understood";
const String usageInformationText1 = """
To use the marker file that will download after this dialog, place it somewhere sensible.
Then, in your map's .conf file, replace this:""";
const String usageInformationText2 = """
With this:""";
const String usageInformationPathTo = "path/to/";
const String usageInformationText3 = """
"Make sure to replace the path here with the correct path to the .conf file!""";

//Add Marker Set Tab
const String addMarkerSetTabHint = "Add a new Marker Set";

//Marker Set Tab
const String deleteMarker = "Delete Marker";
const String markerSetTabHint = "Press the + button to add a marker";
const String markerSetTabFABTooltip = "Add Marker (N)";

//Add Marker Dialog
const String addMarkerTitle = "Add Marker";
const String addMarkerMarkerType = "Type";
const String addMarkerTypePOI = "POI";
const String addMarkerTypeLine = "Line";
