final RegExp regexIDValidation = RegExp(r"^[a-zA-Z0-9_-]+$");
final RegExp regexLabelToID = RegExp(r"\W|-+");
final RegExp regexMultipleSpaces = RegExp(r" +");

String padToMax(int num, int maxNum) {
  int maxLen = maxNum.toString().length;
  return num.toString().padLeft(maxLen);
}

const String monospaceFont = "Inconsolata";

const String appName = "BlueMap Marker Generator";

const String cancel = "Cancel";
const String add = "Add";
const String delete = "Delete";
const String areYouSure = "Are you sure?";
const String understood = "Understood";
const String confirm = "Confirm";

//Properties
//  Shared
const String propertyID = "ID";
const String propertyLabel = "Label";
const String propertyNull = "auto";
const String propertySorting = "Sorting";
//  Shared Markers
const String propertyDetail = "Detail";
//  Marker Set
const String propertyToggleable = "Toggleable";
const String propertyDefaultHidden = "Default Hidden";
//  Marker Base
const String propertyPosition = "Position";
const String propertyListed = "Listed";
const String propertyMinDistance = "Min Distance";
const String propertyMaxDistance = "Max Distance";
//  Marker Poi
const String propertyIcon = "Icon";
const String propertyAnchor = "Anchor";
//  Marker Line
const String propertyLine = "Line";
const String propertyLink = "Link";
const String propertyNewTab = "New Tab";
const String propertyDepthTest = "Depth Test";
const String propertyLineWidth = "Line Width";
const String propertyLineColor = "Line Color";

//Text field error hints
const String cannotBeEmpty = "Can't be empty";
const String noDuplicateIDs = "Can't have a duplicate ID";
const String invalidCharacter = "Invalid character";

//Colour picker
const String hex = "Hex";
const String colourPickerTitle = "Pick a colour";

//Load Save Buttons
const String loadButtonTooltip = "Load Marker Set (Ctrl+O)";
const String saveButtonTooltip = "Save Marker Set (Ctrl+S)";

//Error Dialog
const String errorOpeningFile = "Error while opening file:";

//Usage Information Dialog
const String usageInformationTitle = "Usage Information";
const String usageInformationDoNotShowAgain = "Don't show again this session";
const String usageInformationText1 = """
To use the marker file that will download after this dialog, place it somewhere sensible.
Then, in your map's .conf file, replace this:""";
const String usageInformationText2 = """
With this:""";
const String usageInformationPathTo = "path/to/";
const String usageInformationText3 = """
Make sure to replace the path here with the correct path to the .conf file!""";

//Add Marker Set Tab
const String addMarkerSetTabHint = "Add a new Marker Set";

//Marker Set Tab
const String deleteMarker = "Delete Marker";
const String markerSetTabHint = "Press the + button to add a marker";
const String markerSetTabFABTooltip = "Add Marker (Ctrl+/)";

//Add Marker Dialog
const String addMarkerTitle = "Add Marker";
const String addMarkerMarkerType = "Type";
const String addMarkerTypePOI = "POI";
const String addMarkerTypeLine = "Line";
