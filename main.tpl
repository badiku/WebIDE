<html>
    <head>
        <title>Pythonista WebIDE</title>
        
        <link rel="stylesheet" type="text/css" href="/static/style.css">
        <link rel="stylesheet" href="/static/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">
        <script src="/static/jquery-2.2.0.min.js"></script>
        <script src="/static/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
        
      <style>
        #editor { 
            width: 800px;
            height: 600px;
            }
      </style>
    </head>
    <body class="base3-background">
        <nav class="navbar navbar-default base2-background base00-color">
            <div class="container-fluid">
                <!-- Brand and toggle get grouped for better mobile display -->
                <div class="navbar-header">
                    <a class="navbar-brand" href="#">Pythonista WebIDE</a>
                </div>

                <!-- Collect the nav links, forms, and other content for toggling -->
                <ul class="nav navbar-nav">
                    <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Open <span class="caret"></span></a>
                    <ul class="dropdown-menu base3-background">
                        <li><a href='/'>New</a></li>
                        <li class="divider base01-color"></li>
                        <%def print_tree(tree):
                            for item in tree:
                                if type(tree[item]) == dict:%>
                                    <li class="dropdown-submenu base00-color"><a href="#">{{item}}</a><ul class="dropdown-menu base3-background">
                                    <%print_tree(tree[item])%>
                                    </ul></li>
                                <%else:%>
                                    <li><a class="base00-color" href="/?filename={{tree[item]}}">{{item}}</a></li>
                                <%end
                            end
                        end%>
                        %print_tree(files)
                    </ul>
                    </li>
                </ul>
                <form action="/" class="navbar-form navbar-left" role="search" id="save" method="post">
                    <div class="form-group">
                        %if defined('filename'):
                        <input name="filename" type="text" class="form-control base00-color base3-background" placeholder="Save as..." value="{{filename}}">
                        %else:
                        <input name="filename" type="text" class="form-control base00-color base3-background" placeholder="Save as...">
                        %end
                    </div>
                    <textarea name="code" id="code" style="display:none"> </textarea>
                    <button id="submit" type="submit" class="btn btn-default base01-color base3-background">Save</button>
                </form>
            </div><!-- /.container-fluid -->
        </nav>

        <div class="container">
            %if defined('error'):
            <div class="alert alert-danger">
                <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                {{error}}
            </div>
            %end
            <h2 class="base01-color">Edit File</h2>
            <p>
                <pre id="editor">{{code if defined('code') else ''}}</pre>                
            </p>
            
        </div>
    </body>
    <script src="/static/ace.js" type="text/javascript" charset="utf-8"></script>
    <script>
        var editor = ace.edit("editor");
        editor.getSession().setMode("ace/mode/python");
        window.onload = function() {
                    $("#submit").click(function() {
                  
                        $('#code')[0].value = editor.getValue();
                        $.post('/', $('#save').serialize());
                        return false;
                    });
                }
    </script>
</html>
