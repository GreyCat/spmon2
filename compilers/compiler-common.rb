require 'yaml'
require 'optparse'

class SPMonCompiler
  def initialize
    @dynamic = true
    @out = $stdout
    outfile = nil

    optparse = OptionParser.new { |opts|
      opts.on('-o', '--output=path', 'Write output to a given path') { |o| outfile = o }
      opts.on('-d', '--dynamic', 'Use dynamic runtime (default)') { @dynamic = true }
      opts.on('-s', '--static', 'Use static runtime') { @dynamic = false }
      opts.on('-h', '--help', 'Display this screen') {
        puts opts
        exit
      }
    }
    optparse.parse!

    if ARGV.length == 0
      infile = $stdin.read
    elsif ARGV.length == 1
      infile = File.open(ARGV[0]).read
    else
      puts "More than one file specified - don't know what to do"
      exit 1
    end

    @in = YAML.load(infile)
    @out = File.open(outfile, 'w') unless outfile.nil?
  end
end
