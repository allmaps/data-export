def parseUrl:
    capture("^((?<scheme>[^:/?#]+):)?(//(?<authority>(?<domain>[^/?#:]*)(:(?<port>[0-9]*))?))?((?<path>[^?#]*)\\?)?((?<query>([^#]*)))?(#(?<fragment>(.*)))?");
