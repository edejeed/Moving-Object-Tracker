from flask import Flask, request, jsonify, render_template
import psycopg2

app = Flask(__name__)

# Database connection
connection = psycopg2.connect(
    dbname='track',
    user='postgres',
    password='helloworld',
    host='localhost'
)
cursor = connection.cursor()



def get_coordinates_list():
    cursor = connection.cursor()
    cursor.callproc('group_bird_locations')
    result = cursor.fetchone()[0]   
    cursor.close()
    return result

@app.route('/')
def get_coordinates_route():
    try:
        coordinates_list = get_coordinates_list()
        print(coordinates_list)
        return render_template('app.html', locations=coordinates_list)
    except Exception as e:
        return jsonify({'error': str(e)})
    
@app.route('/get_coordinates/', methods=['GET'])
def get_coordinates():
    try:
        coordinates_list = get_coordinates_list()
        print(coordinates_list)
        return jsonify(locations=coordinates_list)
    except Exception as e:
        return jsonify({'error': str(e)})

@app.route('/map', methods=['GET'])
def get_map():
    return render_template('index.html')

if __name__ == '__main__':
    app.run(debug=True)
