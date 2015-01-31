% Class Email
% paskage base
% author  WN
% created 27/01/2015

classdef Email

    properties(GetAccess = 'public', SetAccess = 'private')
        emailAddress
        appName
    end

    methods(Static)

        function ret = notify(message, subject)

            ret = 0;
            obj = Email.getInstance();

            if isempty(obj.emailAddress)
                Logger.error('Email object is incorrect. Email not sent!');
                return;
            end

            if nargin < 2
                subject = ['Notification from: ' obj.appName];
            end

            footer = '\n\n----------\nAutomatic message sent from MATLAB Email helper. Do not reply.';

            sendmail(obj.emailAddress, subject, sprintf([message footer]));
            ret = 1;
        end

        % GetInstance
        function singleObj = getInstance
            persistent localObj
            if isempty(localObj)
                localObj = Email;
            end
            singleObj = localObj;
        end
    end

    methods (Access = private)

        % Private Constructor
        function obj = Email
            global config
            if  ~isfield(config, 'emailSender') | ~isfield(config, 'emailServer') | ...
                ~isfield(config, 'emailUser') | ~isfield(config, 'emailPassword') | ...
                ~isfield(config, 'emailPort') | ~isfield(config, 'emailAddress')
                Logger.error('Missing Email Configuration!');
                return;
            end

            setpref('Internet','E_mail', config.emailSender);
            setpref('Internet','SMTP_Server', config.emailServer);
            setpref('Internet','SMTP_Username', config.emailUser);
            setpref('Internet','SMTP_Password', config.emailPassword);

            props = java.lang.System.getProperties;
            props.setProperty('mail.smtp.auth','true');
            props.setProperty('mail.smtp.socketFactory.class', 'javax.net.ssl.SSLSocketFactory');
            props.setProperty('mail.smtp.socketFactory.port',config.emailPort);

            obj.emailAddress = config.emailAddress;
            obj.appName = config.appName;
        end
    end
end
