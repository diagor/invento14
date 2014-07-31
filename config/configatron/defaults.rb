# Put all your default configatron settings here.
configatron.general do |general|
	general.application_name = 'INVENTO'
	general.codditt do |codditt|
		codditt.one = '15GRADI'
		codditt.two = 'PROVA'
		#codditt.three = 'PROVA3'

	end
end


configatron.file.storage = :local

#configatron.general.codditt.to_h.send(:[],1.humanize.to_sym)
