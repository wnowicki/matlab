% Class Logger
% package base
% author  WN
% created 24/01/2015
% see http://en.wikipedia.org/wiki/Syslog

classdef Logger

    properties(GetAccess = 'public', SetAccess = 'private')
        fh
    end

    methods(Static)

        function debug(msg)
            ob = Logger.getInstance();
            fprintf(ob.fh, [datestr(now, 'yyyy-mm-dd HH:MM')  ' DEBUG ' msg '\n']);
        end

        function info(msg)
            ob = Logger.getInstance();
            fprintf(ob.fh, [datestr(now, 'yyyy-mm-dd HH:MM')  ' INFO ' msg '\n']);
        end

        function notice(msg)
            ob = Logger.getInstance();
            fprintf(ob.fh, [datestr(now, 'yyyy-mm-dd HH:MM')  ' NOTICE ' msg '\n']);
        end

        function error(msg)
            ob = Logger.getInstance();
            fprintf(ob.fh, [datestr(now, 'yyyy-mm-dd HH:MM')  ' ERROR ' msg '\n']);
        end

        function critical(msg)
            ob = Logger.getInstance();
            fprintf(ob.fh, [datestr(now, 'yyyy-mm-dd HH:MM')  ' CRITICAL ' msg '\n']);
        end

        function alert(msg)
            ob = Logger.getInstance();
            fprintf(ob.fh, [datestr(now, 'yyyy-mm-dd HH:MM')  ' ALERT ' msg '\n']);
        end

        function emergency(msg)
            ob = Logger.getInstance();
            fprintf(ob.fh, [datestr(now, 'yyyy-mm-dd HH:MM')  ' EMERGENCY ' msg '\n']);
        end

        % GetInstance
        function singleObj = getInstance
            persistent localObj
            if isempty(localObj)
                localObj = Logger;
            end
            singleObj = localObj;
        end
    end

    methods (Access = private)

        % Private Constructor
        function obj = Logger
            global config
            if isfield(config, 'logPath')
                path = config.logPath;
            else
                path = 'log.txt';
            end
            obj.fh = fopen(path,'a');
        end
    end
end
