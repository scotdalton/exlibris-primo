PATH = File.dirname(__FILE__) + "/exlibris/primo/"
[ 
  'web_service',
  'holding',
  'related_link',
  'rsrc',
  'toc',
  'searcher',
  'source/aleph'
].each do |library|
  require PATH + library
end