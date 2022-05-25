# POST Endpoint within PSU to trigger the destruction of the ITGlue backup page
Remove-Item $ITGBacPath -Force -Recurse -ErrorAction SilentlyContinue
