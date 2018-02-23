package travix.commands;

import travix.*;

class InstallCommand extends Command {
  
  @:command public var cs = new InstallCsCommand();
  @:command public var node = new InstallNodeCommand();
  
	static inline var TESTS = @:privateAccess Travix.TESTS;
  
  @:defaultCommand
  public function dependencies() {
    
    switch Travix.getInfos() {
      case None:
        Travix.die('$TESTS not found');
        
      case Some(info):
        run('haxelib', ['dev', info.name, '.']);
        
        switch info.dependencies {
        case null:
        case v:
          for (lib in v.keys())
          installLib(lib, v[lib]);
        }
        run('haxelib', ['install', TESTS, '--always']);  
        
        exec('haxelib', ['list']);
    }
  }
}