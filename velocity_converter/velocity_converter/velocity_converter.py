import os
import rclpy
from rclpy.node import Node
from geometry_msgs.msg import Twist


TOPIC_NAME = os.getenv('INPUT_TOPIC')
WHEEL_DISTNCE = os.getenv('WHEEL_DISTNCE', 1.0)
MAX_WHEEL_SPEED = os.getenv('MAX_WHEEL_SPEED', 1.0)


class VelocityConverter(Node):
    def __init__(self):
        super().__init__('velocity_converter')
        print("Velocity topic name: ", TOPIC_NAME)
        print("Distance between wheels: ", WHEEL_DISTNCE)
        print("Max wheel speed: ", MAX_WHEEL_SPEED)
        self.subscription = self.create_subscription(
            Twist,
            TOPIC_NAME,
            self.callback,
            10  # Set the QoS history depth as required
        )
        self.subscription  # prevent unused variable warning

    def callback(self, msg):
        # Process the received message and print new data

        linear_velocity = msg.linear.x
        angular_velocity = msg.angular.z

        speed_right = (angular_velocity * WHEEL_DISTNCE) / 2 + linear_velocity
        speed_left = linear_velocity * 2 - speed_right

        speed_right = 100 * speed_right / MAX_WHEEL_SPEED
        speed_left = 100 * speed_left / MAX_WHEEL_SPEED

        if speed_right > 100: speed_right = 100
        if speed_right < -100: speed_right = -100

        if speed_left > 100: speed_left = 100
        if speed_left < 100: speed_left = -100

        self.get_logger().info(f"Linear Speed (Right Wheel): {speed_right} %")
        self.get_logger().info(f"Linear Speed (Left Wheel): {speed_left} %")


def main(args=None):
    rclpy.init(args=args)
    node = VelocityConverter()
    rclpy.spin(node)
    rclpy.shutdown()


if __name__ == '__main__':
    main()
