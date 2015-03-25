# Matlab Helpers
by [Wojciech Nowicki](http://wojciechnowicki.com)
## Email

### Configuration
```matlab
% Email Configuration
config.emailSender    = '';
config.emailServer    = '';
config.emailPort      = '';
config.emailUser      = '';
config.emailPassword  = '';

% Administrator Email Address
config.emailAddress   = '';
```

### Example

Email will be sent to address defined in configuration.
```matlab
Email.notify(['Process finished in ' num2str(time/60) ' minutes.'], 'Process finished! And the rest of a message...');
```

## Logger
Matlab implementation of [RFC 5424](http://tools.ietf.org/html/rfc5424) eight levels of messages.
### Configuration
- By default `Logger` will be logging into *log.txt* in current folder.
- To change file just put this in configuration:
```matlab
% Path to log file [OPTIONAL]
config.logPath = 'aaa.txt';
```

### Example

```matlab
Logger.notice('Started: Primitive Equation Builder');
Logger.error('Error in ...');
```
## Series
## Slab
## Slab Collection
