from flask import Flask, request, render_template
import geocoder, os
app = Flask(__name__)
env = os.getenv('env')
@app.route('/', methods=['GET'])
def get_geolocation():
    # client_ip = request.remote_addr
    g = geocoder.ip("me")
    if g.ok:
        city = g.city
        latlng = g.latlng
        return render_template('index.html', city=city, latlng=latlng, env=env, ip=g.ip)
    else:
        return 'Failed to retrieve geolocation.'
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080, debug=True)

