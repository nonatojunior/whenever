class Arquivo < ApplicationRecord

	def self.upload_arquivo(arquivo, diretorio)
	  FileUtils.mkdir(diretorio) unless File.exists?(diretorio)
	  arquivo.each do |arquivo|
	  	File.open(File.join(diretorio, arquivo.original_filename), "wb") { |f| f.write(arquivo.read) }
	  end
	end

	def self.download_arquivo(diretorio)
		Zip::File.open(diretorio+'.zip', Zip::File::CREATE) do |arquivo_zip|
      Dir.chdir diretorio
      Dir.glob("**/*").reject { |e| File.directory?(e) }.each do |arquivo|
        puts "Adicionando #{arquivo}"
        arquivo_zip.add(arquivo.sub(diretorio + '/', ''), arquivo)
      end
		end
	end

	def self.remover_arquivos
		# exec("find #{Rails.root}/arquivos -name '*.zip' -mtime +1 -delete") #Tempo em Horas (2 Horas)
		exec("find #{Rails.root}/arquivos -name '*.zip' -cmin +1 -delete") #Tempo em Minutos (60 Minutos)
	end

end
