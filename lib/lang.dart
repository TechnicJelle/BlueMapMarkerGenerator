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
const String propertyAuto = "auto";
const String propertyNone = "none";
const String propertySorting = "Sorting";

//  Shared Markers
const String propertyDetail = "Detail";
const String propertyClasses = "Classes";
const String tooltipClasses =
    "A list of CSS classes that will be added to the marker-element. Useful if you want to style them with custom css or use them in a custom script.";
const String propertyLink = "Link";
const String propertyNewTab = "New Tab";
const String tooltipNewTab =
    "Whether the above link should be opened in a new tab or not.";
const String propertyDepthTest = "Depth Test";
const String tooltipDepthTest =
    "Whether the line should be drawn above all other (hires) terrain. If disabled, hires tiles will be able to cover the line if they are in front of it";
const String propertyLineWidth = "Line Width";
const String tooltipLineWidth = "The width of the line in pixels";
const String propertyLineColor = "Line Color";
const String tooltipLineColor = "The colour of the line";
const String propertyFillColor = "Fill Color";
const String tooltipFillColor = "The colour of the fill";

//  Marker Set
const String tooltipLabelMarkerSet =
    "The label of the marker-set. Will be used as the name of the menu entry.";
const String propertyToggleable = "Toggleable";
const String tooltipToggleable =
    "If this is enabled, the marker-set can be enabled or disabled in the menu.";
const String propertyDefaultHidden = "Default Hidden";
const String tooltipDefaultHidden =
    "If this is true, the marker-set will be hidden by default and can be enabled by the user.";
const String tooltipSortingMarkerSet =
    "A number defining the order that marker-sets will appear in the menu (lower values come first in lists)";

//  Marker Base
const String propertyPosition = "Position";
const String tooltipPosition =
    "The X, Y, and Z coordinates of where the marker (specifically, its anchor) is placed on the map.";
const String tooltipLabelMarker =
    "The name of the marker. Used e.g. in the marker-list.";
const String tooltipSortingMarker =
    "A number defining the (default) order that markers will appear in, in lists and menus (lower values come first in lists)";
const String propertyListed = "Listed";
const String tooltipListed =
    "Whether the marker will be listed in lists and menus, or not.";
const String propertyMinDistance = "Min Distance";
const String propertyMaxDistance = "Max Distance";
const String tooltipDistance =
    "Defaults to “unlimited”, but can be used to limit the distance to the camera at which the marker is shown.";

//  Marker Poi
const String tooltipTypePOI =
    "The POI Marker is the most basic marker. It's a simple icon-image that can be placed anywhere on the map. When clicked, it shows its label (or detail, if set).";
const String tooltipDetailPOI =
    "The text that is shown when you click on the icon. This property allows using any HTML tags. It defaults to the label of the marker.";
const String propertyIcon = "Icon";
const String tooltipIcon =
    "Any url to an image that will be used as the marker's icon. Can be a local file (relative to BlueMap's webroot) or a remote url. The image is not resized, so the image should be exactly as big as you want the icon to be on the map. All image-formats that can be used in an HTML <img> tag are supported.";
const String propertyAnchor = "Anchor";
const String tooltipAnchor =
    "Could also be called \"offset\". It's basically the pixel on the marker-image, that is placed (anchored) at the marker's position. Usually you'd want this to be the middle of the marker-image, but, for example, if you have a needle as your icon, you'd want this to be the tip of the needle.";

//  Marker Line
const String tooltipTypeLine =
    "Line Markers do what their name suggests. They are used to draw a line on the map. If you click on that line, it shows the marker's detail.";
const String propertyLine = "Line";
const String tooltipLine =
    "The list of positions that define this line. The line will be drawn between the positions, in their order.";
const String tooltipDetailLine =
    "The text that is shown when you click on the line. This property allows using any html-tags.";
const String tooltipLinkLine =
    "An optional url that is opened when you click on the line. Disabled if empty.";

//  Marker Shape
const String tooltipTypeShape =
    "A Shape Marker is any flat shape (polygon) placed somewhere on the map. You can use it to mark areas, for example. If you click on the shape, it shows the marker's detail.";
const String propertyShape = "Shape";
const String tooltipShape =
    "The list of x,z positions (without y) that define this shape. The shape will be drawn between the positions, in their order. The last position is automatically connected to the first position.";
const String propertyShapeY = "Shape Y";
const String tooltipShapeY = "The Y-position of the shape.";
const String tooltipDetailShape =
    "The text that is shown when you click on the shape. This property allows using any html-tags.";
const String tooltipLinkShape =
    "An optional url that is opened when you click on the shape. Disabled if empty.";

//Text field error hints
const String cannotBeEmpty = "Can't be empty";
const String noDuplicateIDs = "Can't have a duplicate ID";
const String invalidCharacter = "Invalid character";

//Colour picker
const String hex = "Hex";
const String colourPickerTitle = "Pick a colour";

// Anchor picker
const String anchorPickerTitle = "Select anchor pixel";
const String anchorPickerUpload = "Upload marker icon";

//Load Save Buttons
const String loadButtonTooltip = "Load Marker Set (Ctrl+O)";
const String saveButtonTooltip = "Save Marker Set (Ctrl+S)";

//Error Dialog
const String errorOpeningFile = "Error while opening file:";

//Help Dialog
const String helpTitle = "Help";
const String helpText1 = """
This tool allows you to create marker sets for BlueMap.
Marker sets are used to place markers on the map, like POIs, lines or shapes.
This can be used to mark important locations on the map, like homes or shops, or to draw lines on the map, like roads.
Shapes can be used for things like borders or regions.

For more detailed information on BlueMap Markers, check the """;
const String helpText1Link = "BlueMap Wiki";
const String helpText2 =
    ".\n\nIf you need help with this tool, please join the ";
const String helpText2Link = "BlueMap Discord server";
const String helpText3 = " and ask your questions in ";
const String helpText3link = "#3rd-party-support";
const String helpText4 = ". You're welcome to ping me, @TechnicJelle.";

//Installation Instructions Dialog
const String installInstructionsTitle = "Installation Instructions";
const String installInstructionsDoNotShowAgain =
    "Don't show again this session";
const String installInstructionsText1 = """
To use the marker file that this program generates, you must save it somewhere sensible on your server.
Do not save it in BlueMap's maps configuration directory , as BlueMap will then try to load it as a map, which will not work.
Then, in your map's .conf file, replace this:""";
const String installInstructionsText2 = """
With this:""";
const String installInstructionsPathTo = "path/to/";
const String installInstructionsText3 = """
Make sure to replace the path here with the correct path to the .conf file!""";

//Installation Instructions File Prefix
const String installInstructionsFilePrefix = r"""
#       / ========================================================= \
#       |  Generated with BlueMap Marker Generator by TechnicJelle  |
#       \ ========================================================= /
# 
# This file is not a full BlueMap map config, but only the marker sets collection.
# To use this, you can either just copy the contents of this file directly into your map's .conf file,
# or you can make the BlueMap map config automatically load this .conf file,
# by saving it somewhere sensible on your server, and replacing the already present
# (empty) "marker-sets" collection with the following line in your map's .conf file:
#
#  include required(file("path/to/markers.conf"))
#
""";

//Add Marker Set Tab
const String addMarkerSetTabHint = "Add a new Marker Set";
const String repoLink = "Click to visit the source GitHub repository";
const String tooltipRepoLink = "Feel free to open an issue or pull request!";

//Marker Set Tab
const String deleteMarker = "Delete Marker";
const String markerSetTabHint = "Press the + button to add a marker";
const String markerSetTabFABTooltip = "Add Marker (Ctrl+/)";

//Add Marker Dialog
const String addMarkerTitle = "Add Marker";
const String addMarkerMarkerType = "Type";
const String addMarkerTypePOI = "POI";
const String addMarkerTypeLine = "Line";
const String addMarkerTypeShape = "Shape";
