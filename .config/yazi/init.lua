-- Show the size and modified time on each line
function Linemode:size_and_mtime()
	local modifiedTime = math.floor(self._file.cha.modified or 0)
	if modifiedTime == 0 then
		modifiedTime = ""
	else
		-- modifiedTime = os.date("%d %b %Y - %H:%M", modifiedTime)
		modifiedTime = os.date("%d %b %Y", modifiedTime)
	end

	local filesize = self._file:size()
	return ui.Line(string.format("%s - %s", filesize and ya.readable_size(filesize) or "N/A", modifiedTime))
end
