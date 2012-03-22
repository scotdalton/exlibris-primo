PATH = File.dirname(__FILE__) + "/exlibris/primo/"
[ 
  'web_service',
  'holding',
  'related_link',
  'rsrc',
  'toc',
  'searcher'
].each do |library|
  require PATH + library
end