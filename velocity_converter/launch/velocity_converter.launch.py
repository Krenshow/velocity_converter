from launch import LaunchDescription
from launch_ros.actions import Node


def generate_launch_description():
    return LaunchDescription([
        Node(
            package='velocity_converter',
            executable='velocity_converter',
            output='screen',
            emulate_tty=True
        )
    ])
