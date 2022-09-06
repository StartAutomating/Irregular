This directory contains regular expressions that may be helpful in parsing language agonstic coding conventions.


|Name                                                |Description                                                                            |IsGenerator|
|----------------------------------------------------|---------------------------------------------------------------------------------------|-----------|
|[?<Code_BuildVersion>](BuildVersion.regex.txt)      |Matches a build version                                                                |False      |
|[?<Code_Namespace>](Namespace.regex.txt)            |Finds a Namespace (captures the Name and the Content between {})                       |False      |
|[?<Code_Region>](Region.regex.ps1)                  |Matches a #region #endregion pair. Returns the Name of the Region and the Content.<br/>|True       |
|[?<Code_SemanticVersion>](SemanticVersion.regex.txt)|Matches a Semantic Version.  See [https://semver.org/](https://semver.org/).           |False      |



