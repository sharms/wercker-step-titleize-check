#!/usr/bin/env ruby
require 'titleize'
require 'optparse'

options = { verbose: true, basedir: "./" }
blacklist = ["apt-get", "FISMA"]

OptionParser.new do |opts|
	opts.banner = "Usage: title-checker.rb [options]"
	opts.separator "Scans for .md files and checks their title: field for proper capitalization"
	opts.separator "Options:"
	opts.on("-v", "--verbose", "Verbose mode") do |v|
		options[:verbose] = v
	end
	opts.on("-b", "--basedir basedir", "Which directory to scan") do |basedir|
		basedir << "/" unless basedir.end_with? "/"
		options[:basedir] = basedir 
	end
	opts.on("-h", "--help", "Displays help") do
		puts opts
		exit
	end
end.parse!


errors = false

Dir.glob(options[:basedir] + "**/*.md") do |docfile|
       	if options[:verbose]
		puts "Scanning #{docfile}".titleize
	end
	contents = File.read(docfile)

	contents.each_line do |line|
		if (line =~ /^title:/)
			original_title = line.split(/^title: ?/)[1]
			titleized = original_title.titleize

			blacklist.each do |blacklisted|
				titleized.gsub!(/#{blacklisted}/i, blacklisted)
			end

			if (original_title.strip != titleized.strip)
				puts "Original: #{original_title}"
				puts "Corrected: #{titleized}"
				errors = true
			end
		end
	end
end

unless errors
	exit 0
else
	exit 1
end
