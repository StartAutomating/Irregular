This directory contains regular expressions that may be helpful in parsing language agonstic coding conventions.


|Name                                                |Description                                                                                                                              |Source                       |
|----------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------|-----------------------------|
|[?<Code_BuildVersion>](BuildVersion.regex.txt)      |Matches a build version                                                                                                                  |
|[?<Code_Namespace>](Namespace.regex.txt)            |Finds a Namespace (captures the Name and the Content between {})                                                                         |
|[?<Code_PackageVersion>](PackageVersion.regex.txt)  |Matches a Package Name with a Version.<br/>Includes captures for Name, Version, Major, Minor, Patch, Build, and Prerelease, and Extension|
|[?<Code_Region>](Region.regex.ps1)                  |Matches a #region #endregion pair. Returns the Name of the Region and the Content.<br/>                                                  |[generator](Region.regex.ps1)|
|[?<Code_SemanticVersion>](SemanticVersion.regex.txt)|Matches a Semantic Version.  See [https://semver.org/](https://semver.org/).                                                             |



