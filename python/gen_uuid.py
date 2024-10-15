from uuid import uuid4

def printable(version = "V2.0.0", serial=""):
    return f"""
        <div>
          <p>LaminAir {version}</p>
          <p>Serial: {str(serial)[0:8]}</p>
          <p>https://breathesafe-llc.myshopify.com</p>

          <br>
          <br>
          <br>

        </div>
    """
if __name__ == "__main__":
    file = open("serials.html", 'w')

    lines = [
        "<html>",
        "<body>"
    ]

    for i in range(10):
        lines.append(
            printable(serial=uuid4())
        )

    file.writelines(lines)
    file.close()
