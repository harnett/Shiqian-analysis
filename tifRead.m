function frame = tifRead(Info, index)

    %SBXREAD Read individual frames from .sbx file.
    %   frame = SBXREAD(Info, index) gives the frame at the indicated index.
    %
    %   Info: structure
    %       Info structure for tifstack, mirroring the one that comes with
    %       sbx files
    %
    %   index: integer
    %       Index of the frame to be read. The first index is 0.
    %
    %   frame: uint16
    %       Array with dimensions (Info.sz(1), Info.sz(2)).
    